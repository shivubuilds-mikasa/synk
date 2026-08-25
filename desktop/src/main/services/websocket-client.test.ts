/** Tests for SynkWebSocketClient. */

import { describe, it, expect, beforeEach, vi, afterEach } from 'vitest';
import { SynkWebSocketClient, WebSocketConnectionState, DEFAULT_CONFIG } from './websocket-client';
import { SyncMessageType, ServerMessage, ClipboardUpdateRelayMessage, AuthSuccessMessage, ErrorMessage } from '../models/sync';

// Mock WebSocket
class MockWebSocket {
  static instances: MockWebSocket[] = [];

  url: string;
  readyState: number = 0; // CONNECTING
  sentMessages: string[] = [];
  onopen: (() => void) | null = null;
  onmessage: ((event: { data: Buffer }) => void) | null = null;
  onerror: ((error: Error) => void) | null = null;
  onclose: ((code: number, reason: string) => void) | null = null;
  closed = false;
  private eventHandlers: Map<string, Function[]> = new Map();

  constructor(url: string) {
    this.url = url;
    MockWebSocket.instances.push(this);
    // Simulate async connection - but don't auto-open, let tests control it
  }

  on(event: string, handler: Function) {
    if (!this.eventHandlers.has(event)) {
      this.eventHandlers.set(event, []);
    }
    this.eventHandlers.get(event)!.push(handler);
  }

  off(event: string, handler: Function) {
    const handlers = this.eventHandlers.get(event);
    if (handlers) {
      const idx = handlers.indexOf(handler);
      if (idx !== -1) handlers.splice(idx, 1);
    }
  }

  private emit(event: string, ...args: any[]) {
    const handlers = this.eventHandlers.get(event);
    if (handlers) {
      handlers.forEach(h => h(...args));
    }
  }

  send(data: string) {
    this.sentMessages.push(data);
  }

  close(code?: number, reason?: string) {
    this.closed = true;
    this.readyState = 3; // CLOSED
    this.emit('close', code ?? 1000, reason ?? 'Normal closure');
    this.onclose?.(code ?? 1000, reason ?? 'Normal closure');
  }

  simulateOpen() {
    this.readyState = 1; // OPEN
    this.emit('open');
    this.onopen?.();
  }

  simulateMessage(data: string) {
    this.emit('message', Buffer.from(data));
    this.onmessage?.({ data: Buffer.from(data) });
  }

  simulateError(error: Error) {
    this.emit('error', error);
    this.onerror?.(error);
  }

  simulateClose(code?: number, reason?: string) {
    this.closed = true;
    this.readyState = 3; // CLOSED
    this.emit('close', code ?? 1000, reason ?? 'Normal closure');
    this.onclose?.(code ?? 1000, reason ?? 'Normal closure');
  }

  static clear() {
    MockWebSocket.instances = [];
  }

  static getLastInstance(): MockWebSocket | null {
    return MockWebSocket.instances[MockWebSocket.instances.length - 1] ?? null;
  }
}

// Mock WebSocket constructor globally
vi.mock('ws', () => ({
  default: vi.fn().mockImplementation((url: string) => new MockWebSocket(url)),
  WebSocket: vi.fn().mockImplementation((url: string) => new MockWebSocket(url)),
  CONNECTING: 0,
  OPEN: 1,
  CLOSING: 2,
  CLOSED: 3,
}));

describe('SynkWebSocketClient', () => {
  let client: SynkWebSocketClient;
  const deviceId = 'test-device-id';
  const authToken = 'synk_test_token';
  const wsUrl = 'ws://localhost:8000/ws/test-device-id';

  beforeEach(() => {
    vi.useFakeTimers();
    MockWebSocket.clear();
    client = new SynkWebSocketClient(wsUrl, deviceId, authToken);
  });

  afterEach(() => {
    vi.useRealTimers();
    client.dispose();
    MockWebSocket.clear();
  });

  describe('connection lifecycle', () => {
    it('starts in disconnected state', () => {
      expect(client.connectionState).toBe(WebSocketConnectionState.Disconnected);
      expect(client.isConnected).toBe(false);
    });

    it('transitions to connecting on connect()', async () => {
      const connectPromise = client.connect();
      // Don't run all timers - connection timeout would fire
      await connectPromise;

      expect(client.connectionState).toBe(WebSocketConnectionState.Connecting);
    });

    it('sends auth message on open', async () => {
      await client.connect();

      const ws = MockWebSocket.getLastInstance();
      expect(ws).not.toBeNull();
      ws!.simulateOpen();
      // Don't run all timers - connection timeout would fire before auth

      expect(ws!.sentMessages.length).toBe(1);

      const authMsg = JSON.parse(ws!.sentMessages[0]);
      expect(authMsg.type).toBe('auth');
      expect(authMsg.token).toBe(authToken);
    });

    it('authenticates successfully on auth.success', async () => {
      await client.connect();

      const ws = MockWebSocket.getLastInstance();
      expect(ws).not.toBeNull();
      ws!.simulateOpen();
      // Don't run all timers - connection timeout would fire before auth

      // Simulate auth.success response
      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: {},
      };
      ws!.simulateMessage(JSON.stringify(authSuccess));
      // Don't run all timers - ping timer would fire

      expect(client.connectionState).toBe(WebSocketConnectionState.Connected);
      expect(client.isConnected).toBe(true);
    });

    it('starts ping timer after authentication', async () => {
      await client.connect();

      const ws = MockWebSocket.getLastInstance();
      ws!.simulateOpen();
      // Don't run all timers - connection timeout would fire before auth

      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: {},
      };
      ws!.simulateMessage(JSON.stringify(authSuccess));
      // Don't run all timers - ping timer would fire

      // Advance time by ping interval - just advance, don't run all
      vi.advanceTimersByTime(DEFAULT_CONFIG.pingIntervalMs);

      // Should have sent a ping
      expect(ws!.sentMessages.length).toBeGreaterThan(1);
      const pingMsg = JSON.parse(ws!.sentMessages[1]);
      expect(pingMsg.type).toBe(SyncMessageType.PING);
    });

    it('emits message event for relay messages', async () => {
      const messageHandler = vi.fn();
      client.on('message', messageHandler);

      await client.connect();

      const ws = MockWebSocket.getLastInstance();
      ws!.simulateOpen();
      // Don't run all timers - connection timeout would fire before auth

      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: {},
      };
      ws!.simulateMessage(JSON.stringify(authSuccess));
      // Don't run all timers - ping timer would fire

      // Simulate clipboard relay
      const relay: ClipboardUpdateRelayMessage = {
        type: SyncMessageType.CLIPBOARD_UPDATE_RELAY,
        version: 1,
        message_id: 'relay-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: { content_type: 'text', text: 'Hello from other device' },
        source_device_id: 'other-device',
      };
      ws!.simulateMessage(JSON.stringify(relay));
      // Message handling is synchronous

      expect(messageHandler).toHaveBeenCalledTimes(2);
      // First call is auth.success, second is the relay
      const receivedMsg = messageHandler.mock.calls[1][0] as ServerMessage;
      expect(receivedMsg.type).toBe(SyncMessageType.CLIPBOARD_UPDATE_RELAY);
    });

    it('handles connection error', async () => {
      const errorHandler = vi.fn();
      client.on('error', errorHandler);

      await client.connect();
      // Don't run all timers - connection timeout would fire

      const ws = MockWebSocket.getLastInstance();
      ws!.simulateOpen();
      // Don't run all timers - keep connection timeout pending

      // Simulate connection error BEFORE auth - should trigger error state
      ws!.simulateError(new Error('Connection failed'));

      // Error handler is called synchronously in handleConnectionError
      // State transitions: Error -> (onClose) -> Disconnected, both synchronously
      expect([WebSocketConnectionState.Error, WebSocketConnectionState.Disconnected]).toContain(client.connectionState);
      expect(errorHandler).toHaveBeenCalled();

      // Disconnect immediately to cancel any scheduled reconnection
      await client.disconnect();
      client.dispose();
      MockWebSocket.clear();
      // Advance and run timers to let any scheduled reconnects fire (and do nothing since disposed)
      vi.advanceTimersByTime(DEFAULT_CONFIG.initialReconnectDelayMs + 100);
      await vi.runAllTimersAsync();
    });

    it('disconnects gracefully', async () => {
      await client.connect();

      const ws = MockWebSocket.getLastInstance();
      ws!.simulateOpen();
      // Don't run all timers - connection timeout would fire before auth

      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: {},
      };
      ws!.simulateMessage(JSON.stringify(authSuccess));
      // Don't run all timers - ping timer would fire

      expect(client.isConnected).toBe(true);

      await client.disconnect();
      await vi.runAllTimersAsync();

      expect(client.connectionState).toBe(WebSocketConnectionState.Disconnected);
      expect(client.isConnected).toBe(false);
      expect(ws!.closed).toBe(true);
    });

    it('does not reconnect after explicit disconnect', async () => {
      await client.connect();

      const ws = MockWebSocket.getLastInstance();
      ws!.simulateOpen();
      // Don't run all timers - connection timeout would fire before auth

      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: {},
      };
      ws!.simulateMessage(JSON.stringify(authSuccess));
      // Don't run all timers - ping timer would fire

      await client.disconnect();
      await vi.runAllTimersAsync();

      // Simulate close event - should not reconnect
      ws!.simulateClose();
      vi.advanceTimersByTime(DEFAULT_CONFIG.initialReconnectDelayMs + 100);
      await vi.runAllTimersAsync();

      expect(MockWebSocket.instances.length).toBe(1); // No new connection
    });
  });

  describe('message sending', () => {
    beforeEach(async () => {
      await client.connect();

      const ws = MockWebSocket.getLastInstance();
      ws!.simulateOpen();
      // Don't run all timers - connection timeout would fire before auth

      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: {},
      };
      ws!.simulateMessage(JSON.stringify(authSuccess));
      // Don't run all timers - ping timer would fire
    });

    it('sends clipboard update', async () => {
      const result = await client.sendClipboardUpdate('msg-1', 'Hello world');

      expect(result).toBe(true);
      const ws = MockWebSocket.getLastInstance();
      const msg = JSON.parse(ws!.sentMessages[1]); // Index 1 is after auth
      expect(msg.type).toBe(SyncMessageType.CLIPBOARD_UPDATE);
      expect(msg.payload.text).toBe('Hello world');
    });

    it('sends delivery receipt', async () => {
      const result = await client.sendDeliveryReceipt('msg-1', 'received-msg-1');

      expect(result).toBe(true);
      const ws = MockWebSocket.getLastInstance();
      const msg = JSON.parse(ws!.sentMessages[1]);
      expect(msg.type).toBe(SyncMessageType.DELIVERY_RECEIPT);
      expect(msg.payload.received_message_id).toBe('received-msg-1');
    });

    it('sends history sync request', async () => {
      const result = await client.sendHistorySyncRequest('msg-1', 20);

      expect(result).toBe(true);
      const ws = MockWebSocket.getLastInstance();
      const msg = JSON.parse(ws!.sentMessages[1]);
      expect(msg.type).toBe(SyncMessageType.HISTORY_SYNC_REQUEST);
      expect(msg.payload.limit).toBe(20);
    });

    it('sends ping', async () => {
      const result = await client.sendPing('ping-1');

      expect(result).toBe(true);
      const ws = MockWebSocket.getLastInstance();
      const msg = JSON.parse(ws!.sentMessages[1]);
      expect(msg.type).toBe(SyncMessageType.PING);
      expect(msg.message_id).toBe('ping-1');
    });

    it('returns false when not connected', async () => {
      await client.disconnect();

      const result = await client.sendClipboardUpdate('msg-1', 'test');
      expect(result).toBe(false);
    });
  });

  describe('error handling', () => {
    it('handles malformed messages gracefully', async () => {
      const errorHandler = vi.fn();
      client.on('error', errorHandler);

      await client.connect();

      const ws = MockWebSocket.getLastInstance();
      ws!.simulateOpen();
      // Don't run all timers - connection timeout would fire before auth

      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: {},
      };
      ws!.simulateMessage(JSON.stringify(authSuccess));
      // Don't run all timers - ping timer would fire

      // Send malformed JSON
      ws!.simulateMessage('not valid json');
      // Error handling is synchronous

      expect(errorHandler).toHaveBeenCalled();

      // Disconnect immediately to cancel any scheduled reconnection/ping
      await client.disconnect();
      client.dispose();
      MockWebSocket.clear();
    });

    it('handles unknown message types gracefully', async () => {
      const errorHandler = vi.fn();
      client.on('error', errorHandler);

      await client.connect();

      const ws = MockWebSocket.getLastInstance();
      ws!.simulateOpen();
      // Don't run all timers - connection timeout would fire before auth

      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: {},
      };
      ws!.simulateMessage(JSON.stringify(authSuccess));
      // Don't run all timers - ping timer would fire

      // Send unknown message type
      ws!.simulateMessage(JSON.stringify({ type: 'unknown.type', version: 1, message_id: 'x', device_id: deviceId, timestamp: new Date().toISOString() }));
      // Error handling is synchronous

      expect(errorHandler).toHaveBeenCalled();

      // Disconnect immediately to cancel any scheduled reconnection/ping
      await client.disconnect();
      client.dispose();
      MockWebSocket.clear();
    });
  });

  describe('state changes', () => {
    it('emits stateChange events', async () => {
      const stateHandler = vi.fn();
      client.on('stateChange', stateHandler);

      await client.connect();
      // Don't run all timers - connection timeout would fire

      expect(stateHandler).toHaveBeenCalledWith(WebSocketConnectionState.Connecting);
    });

    it('emits Connected state after auth', async () => {
      const stateHandler = vi.fn();
      client.on('stateChange', stateHandler);

      await client.connect();

      const ws = MockWebSocket.getLastInstance();
      ws!.simulateOpen();
      // Don't run all timers - connection timeout would fire before auth

      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: {},
      };
      ws!.simulateMessage(JSON.stringify(authSuccess));
      // Don't run all timers - ping timer would fire

      expect(stateHandler).toHaveBeenCalledWith(WebSocketConnectionState.Connected);
    });
  });
});