/** Tests for SynkWebSocketClient. */

import {
  describe,
  it,
  expect,
  beforeEach,
  vi,
  afterEach,
} from 'vitest';

import {
  SynkWebSocketClient,
  WebSocketConnectionState,
  DEFAULT_CONFIG,
} from './websocket-client';

import {
  SyncMessageType,
  ContentType,
  ServerMessage,
  ClipboardUpdateRelayMessage,
  AuthSuccessMessage,
} from '../models/sync';


// ============================================================
// Mock WebSocket
// ============================================================

class MockWebSocket {
  static instances: MockWebSocket[] = [];

  url: string;
  readyState = 0;

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
      const index = handlers.indexOf(handler);

      if (index !== -1) {
        handlers.splice(index, 1);
      }
    }
  }

  private emit(event: string, ...args: any[]) {
    const handlers = this.eventHandlers.get(event);

    if (handlers) {
      handlers.forEach((handler) => {
        handler(...args);
      });
    }
  }

  send(data: string) {
    this.sentMessages.push(data);
  }

  close(code?: number, reason?: string) {
    this.closed = true;
    this.readyState = 3;

    const closeCode = code ?? 1000;
    const closeReason = reason ?? 'Normal closure';

    this.emit(
      'close',
      closeCode,
      closeReason
    );

    this.onclose?.(
      closeCode,
      closeReason
    );
  }

  simulateOpen() {
    this.readyState = 1;

    this.emit('open');
    this.onopen?.();
  }

  simulateMessage(data: string) {
    const buffer = Buffer.from(data);

    this.emit(
      'message',
      buffer
    );

    this.onmessage?.({
      data: buffer,
    });
  }

  simulateError(error: Error) {
    this.emit(
      'error',
      error
    );

    this.onerror?.(error);
  }

  simulateClose(
    code?: number,
    reason?: string
  ) {
    this.closed = true;
    this.readyState = 3;

    const closeCode = code ?? 1000;
    const closeReason = reason ?? 'Normal closure';

    this.emit(
      'close',
      closeCode,
      closeReason
    );

    this.onclose?.(
      closeCode,
      closeReason
    );
  }

  static clear() {
    MockWebSocket.instances = [];
  }

  static getLastInstance(): MockWebSocket | null {
    return (
      MockWebSocket.instances[
        MockWebSocket.instances.length - 1
      ] ?? null
    );
  }
}


// ============================================================
// Mock ws module
// ============================================================

vi.mock('ws', () => ({
  default: vi.fn().mockImplementation(
    (url: string) => new MockWebSocket(url)
  ),

  WebSocket: vi.fn().mockImplementation(
    (url: string) => new MockWebSocket(url)
  ),

  CONNECTING: 0,
  OPEN: 1,
  CLOSING: 2,
  CLOSED: 3,
}));


// ============================================================
// Tests
// ============================================================

describe('SynkWebSocketClient', () => {
  let client: SynkWebSocketClient;

  const deviceId = 'test-device-id';

  const authToken = 'synk_test_token';

  const wsUrl =
    'ws://localhost:8000/ws/test-device-id';


  // ==========================================================
  // Setup
  // ==========================================================

  beforeEach(() => {
    vi.useFakeTimers();

    MockWebSocket.clear();

    client = new SynkWebSocketClient(
      wsUrl,
      deviceId,
      authToken
    );
  });


  afterEach(() => {
    vi.useRealTimers();

    client.dispose();

    MockWebSocket.clear();
  });


  // ==========================================================
  // Connection lifecycle
  // ==========================================================

  describe('connection lifecycle', () => {

    it('starts in disconnected state', () => {
      expect(
        client.connectionState
      ).toBe(
        WebSocketConnectionState.Disconnected
      );

      expect(
        client.isConnected
      ).toBe(false);
    });


    it('transitions to connecting on connect()', async () => {
      const connectPromise =
        client.connect();

      await connectPromise;

      expect(
        client.connectionState
      ).toBe(
        WebSocketConnectionState.Connecting
      );
    });


    it('sends auth message on open', async () => {
      await client.connect();

      const ws =
        MockWebSocket.getLastInstance();

      expect(ws).not.toBeNull();

      ws!.simulateOpen();

      expect(
        ws!.sentMessages.length
      ).toBe(1);

      const authMsg =
        JSON.parse(
          ws!.sentMessages[0]
        );

      expect(
        authMsg.type
      ).toBe('auth');

      expect(
        authMsg.token
      ).toBe(authToken);
    });


    it('authenticates successfully on auth.success', async () => {
      await client.connect();

      const ws =
        MockWebSocket.getLastInstance();

      expect(ws).not.toBeNull();

      ws!.simulateOpen();

      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: {},
      };

      ws!.simulateMessage(
        JSON.stringify(authSuccess)
      );

      expect(
        client.connectionState
      ).toBe(
        WebSocketConnectionState.Connected
      );

      expect(
        client.isConnected
      ).toBe(true);
    });


    it('starts ping timer after authentication', async () => {
      await client.connect();

      const ws =
        MockWebSocket.getLastInstance();

      expect(ws).not.toBeNull();

      ws!.simulateOpen();

      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: {},
      };

      ws!.simulateMessage(
        JSON.stringify(authSuccess)
      );

      vi.advanceTimersByTime(
        DEFAULT_CONFIG.pingIntervalMs
      );

      expect(
        ws!.sentMessages.length
      ).toBeGreaterThan(1);

      const pingMsg =
        JSON.parse(
          ws!.sentMessages[1]
        );

      expect(
        pingMsg.type
      ).toBe(
        SyncMessageType.PING
      );
    });


    it('emits message event for relay messages', async () => {
      const messageHandler =
        vi.fn();

      client.on(
        'message',
        messageHandler
      );

      await client.connect();

      const ws =
        MockWebSocket.getLastInstance();

      expect(ws).not.toBeNull();

      ws!.simulateOpen();

      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: {},
      };

      ws!.simulateMessage(
        JSON.stringify(authSuccess)
      );

      const relay: ClipboardUpdateRelayMessage = {
        type:
          SyncMessageType.CLIPBOARD_UPDATE_RELAY,

        version: 1,

        message_id: 'relay-1',

        device_id: deviceId,

        timestamp:
          new Date().toISOString(),

        payload: {
          content_type: ContentType.TEXT,
          text: 'Hello from other device',
        },

        source_device_id:
          'other-device',
      };

      ws!.simulateMessage(
        JSON.stringify(relay)
      );

      expect(
        messageHandler
      ).toHaveBeenCalledTimes(2);

      const receivedMsg =
        messageHandler.mock
          .calls[1][0] as ServerMessage;

      expect(
        receivedMsg.type
      ).toBe(
        SyncMessageType.CLIPBOARD_UPDATE_RELAY
      );
    });


    it('handles connection error', async () => {
      const errorHandler =
        vi.fn();

      client.on(
        'error',
        errorHandler
      );

      await client.connect();

      const ws =
        MockWebSocket.getLastInstance();

      expect(ws).not.toBeNull();

      ws!.simulateOpen();

      ws!.simulateError(
        new Error(
          'Connection failed'
        )
      );

      expect([
        WebSocketConnectionState.Error,
        WebSocketConnectionState.Disconnected,
      ]).toContain(
        client.connectionState
      );

      expect(
        errorHandler
      ).toHaveBeenCalled();

      await client.disconnect();

      client.dispose();

      MockWebSocket.clear();

      vi.advanceTimersByTime(
        DEFAULT_CONFIG.initialReconnectDelayMs +
        100
      );

      await vi.runAllTimersAsync();
    });


    it('disconnects gracefully', async () => {
      await client.connect();

      const ws =
        MockWebSocket.getLastInstance();

      expect(ws).not.toBeNull();

      ws!.simulateOpen();

      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: {},
      };

      ws!.simulateMessage(
        JSON.stringify(authSuccess)
      );

      expect(
        client.isConnected
      ).toBe(true);

      await client.disconnect();

      await vi.runAllTimersAsync();

      expect(
        client.connectionState
      ).toBe(
        WebSocketConnectionState.Disconnected
      );

      expect(
        client.isConnected
      ).toBe(false);

      expect(
        ws!.closed
      ).toBe(true);
    });


    it('does not reconnect after explicit disconnect', async () => {
      await client.connect();

      const ws =
        MockWebSocket.getLastInstance();

      expect(ws).not.toBeNull();

      ws!.simulateOpen();

      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: {},
      };

      ws!.simulateMessage(
        JSON.stringify(authSuccess)
      );

      await client.disconnect();

      await vi.runAllTimersAsync();

      ws!.simulateClose();

      vi.advanceTimersByTime(
        DEFAULT_CONFIG.initialReconnectDelayMs +
        100
      );

      await vi.runAllTimersAsync();

      expect(
        MockWebSocket.instances.length
      ).toBe(1);
    });

  });


  // ==========================================================
  // Message sending
  // ==========================================================

  describe('message sending', () => {

    beforeEach(async () => {
      await client.connect();

      const ws =
        MockWebSocket.getLastInstance();

      expect(ws).not.toBeNull();

      ws!.simulateOpen();

      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: {},
      };

      ws!.simulateMessage(
        JSON.stringify(authSuccess)
      );
    });


    it('sends clipboard update', async () => {
      const result =
        await client.sendClipboardUpdate(
          'msg-1',
          'Hello world'
        );

      expect(result).toBe(true);

      const ws =
        MockWebSocket.getLastInstance();

      expect(ws).not.toBeNull();

      const msg =
        JSON.parse(
          ws!.sentMessages[1]
        );

      expect(
        msg.type
      ).toBe(
        SyncMessageType.CLIPBOARD_UPDATE
      );

      expect(
        msg.payload.text
      ).toBe(
        'Hello world'
      );
    });


    it('sends delivery receipt', async () => {
      const result =
        await client.sendDeliveryReceipt(
          'msg-1',
          'received-msg-1'
        );

      expect(result).toBe(true);

      const ws =
        MockWebSocket.getLastInstance();

      expect(ws).not.toBeNull();

      const msg =
        JSON.parse(
          ws!.sentMessages[1]
        );

      expect(
        msg.type
      ).toBe(
        SyncMessageType.DELIVERY_RECEIPT
      );

      expect(
        msg.payload.received_message_id
      ).toBe(
        'received-msg-1'
      );
    });


    it('sends history sync request', async () => {
      const result =
        await client.sendHistorySyncRequest(
          'msg-1',
          20
        );

      expect(result).toBe(true);

      const ws =
        MockWebSocket.getLastInstance();

      expect(ws).not.toBeNull();

      const msg =
        JSON.parse(
          ws!.sentMessages[1]
        );

      expect(
        msg.type
      ).toBe(
        SyncMessageType.HISTORY_SYNC_REQUEST
      );

      expect(
        msg.payload.limit
      ).toBe(20);
    });


    it('sends ping', async () => {
      const result =
        await client.sendPing(
          'ping-1'
        );

      expect(result).toBe(true);

      const ws =
        MockWebSocket.getLastInstance();

      expect(ws).not.toBeNull();

      const msg =
        JSON.parse(
          ws!.sentMessages[1]
        );

      expect(
        msg.type
      ).toBe(
        SyncMessageType.PING
      );

      expect(
        msg.message_id
      ).toBe(
        'ping-1'
      );
    });


    it('returns false when not connected', async () => {
      await client.disconnect();

      const result =
        await client.sendClipboardUpdate(
          'msg-1',
          'test'
        );

      expect(result).toBe(false);
    });

  });


  // ==========================================================
  // Error handling
  // ==========================================================

  describe('error handling', () => {

    it('handles malformed messages gracefully', async () => {
      const errorHandler =
        vi.fn();

      client.on(
        'error',
        errorHandler
      );

      await client.connect();

      const ws =
        MockWebSocket.getLastInstance();

      expect(ws).not.toBeNull();

      ws!.simulateOpen();

      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: {},
      };

      ws!.simulateMessage(
        JSON.stringify(authSuccess)
      );

      ws!.simulateMessage(
        'not valid json'
      );

      expect(
        errorHandler
      ).toHaveBeenCalled();

      await client.disconnect();

      client.dispose();

      MockWebSocket.clear();
    });


    it('handles unknown message types gracefully', async () => {
      const errorHandler =
        vi.fn();

      client.on(
        'error',
        errorHandler
      );

      await client.connect();

      const ws =
        MockWebSocket.getLastInstance();

      expect(ws).not.toBeNull();

      ws!.simulateOpen();

      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp: new Date().toISOString(),
        payload: {},
      };

      ws!.simulateMessage(
        JSON.stringify(authSuccess)
      );

      ws!.simulateMessage(
        JSON.stringify({
          type: 'unknown.type',
          version: 1,
          message_id: 'x',
          device_id: deviceId,
          timestamp:
            new Date().toISOString(),
        })
      );

      expect(
        errorHandler
      ).toHaveBeenCalled();

      await client.disconnect();

      client.dispose();

      MockWebSocket.clear();
    });

  });


  // ==========================================================
  // State changes
  // ==========================================================

  describe('state changes', () => {

    it('emits stateChange events', async () => {
      const stateHandler =
        vi.fn();

      client.on(
        'stateChange',
        stateHandler
      );

      await client.connect();

      expect(
        stateHandler
      ).toHaveBeenCalledWith(
        WebSocketConnectionState.Connecting
      );
    });


    it('emits Connected state after auth', async () => {
      const stateHandler =
        vi.fn();

      client.on(
        'stateChange',
        stateHandler
      );

      await client.connect();

      const ws =
        MockWebSocket.getLastInstance();

      expect(ws).not.toBeNull();

      ws!.simulateOpen();

      const authSuccess: AuthSuccessMessage = {
        type: SyncMessageType.AUTH_SUCCESS,
        version: 1,
        message_id: 'msg-1',
        device_id: deviceId,
        timestamp:
          new Date().toISOString(),
        payload: {},
      };

      ws!.simulateMessage(
        JSON.stringify(authSuccess)
      );

      expect(
        stateHandler
      ).toHaveBeenCalledWith(
        WebSocketConnectionState.Connected
      );
    });

  });

});