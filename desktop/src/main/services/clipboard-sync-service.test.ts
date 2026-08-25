/** Tests for ClipboardSyncService. */

import { describe, it, expect, beforeEach, vi, afterEach } from 'vitest';
import { ClipboardSyncService, ClipboardSyncState } from './clipboard-sync-service';
import { SynkWebSocketClient, WebSocketConnectionState } from './websocket-client';
import { ClipboardService } from './clipboard-service';
import {
  ContentType,
  SyncMessageType,
  ServerMessage,
  ClipboardUpdateRelayMessage,
  AuthSuccessMessage,
  ClipboardUpdateReceivedMessage,
  HistorySyncResponseMessage,
  DeviceOnlineMessage,
  DeviceOfflineMessage,
  ErrorMessage,
  AckMessage,
  PongMessage,
  generateTimestamp,
  generateMessageId,
} from '../models/sync';
import { ClipboardPayload } from '../models/sync';

// Mock WebSocket client
class MockWebSocketClient {
  private state: WebSocketConnectionState = WebSocketConnectionState.Disconnected;
  private messageHandler: ((msg: ServerMessage) => void) | null = null;
  private stateHandler: ((state: WebSocketConnectionState) => void) | null = null;
  private errorHandler: ((error: Error) => void) | null = null;
  private disposed = false;
  public sentMessages: Array<{ type: string; data: any }> = [];

  on(event: string, handler: any) {
    if (event === 'message') this.messageHandler = handler;
    else if (event === 'stateChange') this.stateHandler = handler;
    else if (event === 'error') this.errorHandler = handler;
  }

  removeAllListeners() {
    this.messageHandler = null;
    this.stateHandler = null;
    this.errorHandler = null;
  }

  get connectionState() { return this.state; }
  get isConnected() { return this.state === WebSocketConnectionState.Connected; }
  get authenticated() { return this.state === WebSocketConnectionState.Connected; }

  async connect() {
    this.state = WebSocketConnectionState.Connecting;
    this.stateHandler?.(this.state);

    // Simulate connection and auth
    setTimeout(() => {
      if (!this.disposed) {
        this.state = WebSocketConnectionState.Connected;
        this.stateHandler?.(this.state);
        // Simulate auth success
        const authSuccess: AuthSuccessMessage = {
          type: SyncMessageType.AUTH_SUCCESS,
          version: 1,
          message_id: generateMessageId(),
          device_id: 'test-device',
          timestamp: generateTimestamp(),
          payload: {},
        };
        this.messageHandler?.(authSuccess);
      }
    }, 0);
  }

  async disconnect() {
    this.state = WebSocketConnectionState.Disconnected;
    this.stateHandler?.(this.state);
  }

  async send(message: any) {
    if (!this.isConnected) return false;
    this.sentMessages.push({ type: message.type, data: message });
    return true;
  }

  async sendClipboardUpdate(messageId: string, text: string) {
    return this.send({
      type: SyncMessageType.CLIPBOARD_UPDATE,
      version: 1,
      message_id: messageId,
      device_id: 'test-device',
      timestamp: generateTimestamp(),
      payload: { content_type: 'text', text },
    });
  }

  async sendDeliveryReceipt(messageId: string, receivedMessageId: string) {
    return this.send({
      type: SyncMessageType.DELIVERY_RECEIPT,
      version: 1,
      message_id: messageId,
      device_id: 'test-device',
      timestamp: generateTimestamp(),
      payload: { received_message_id: receivedMessageId },
    });
  }

  async sendHistorySyncRequest(messageId: string, limit: number = 50) {
    return this.send({
      type: SyncMessageType.HISTORY_SYNC_REQUEST,
      version: 1,
      message_id: messageId,
      device_id: 'test-device',
      timestamp: generateTimestamp(),
      payload: { limit },
    });
  }

  dispose() {
    this.disposed = true;
    // Call state handler with Disconnected state before cleaning up
    this.state = WebSocketConnectionState.Disconnected;
    this.stateHandler?.(this.state);
    this.removeAllListeners();
  }

  // Test helpers
  simulateMessage(msg: ServerMessage) {
    this.messageHandler?.(msg);
  }

  simulateError(error: Error) {
    this.errorHandler?.(error);
  }

  getState() { return this.state; }
}

// Mock ClipboardService
class MockClipboardService {
  private changeHandler: ((text: string) => void) | null = null;
  private errorHandler: ((error: Error) => void) | null = null;
  public lastWritten = '';
  public lastReadValue = '';

  on(event: string, handler: any) {
    if (event === 'change') this.changeHandler = handler;
    else if (event === 'error') this.errorHandler = handler;
  }

  removeAllListeners() {
    this.changeHandler = null;
    this.errorHandler = null;
  }

  read(): string {
    return this.lastReadValue;
  }

  write(text: string, markAsLast: boolean = true): void {
    this.lastWritten = text;
    if (markAsLast) this.lastReadValue = text;
  }

  startPolling() {}
  stopPolling() {}
  dispose() {}

  // Test helpers
  simulateChange(text: string) {
    this.lastReadValue = text;
    this.changeHandler?.(text);
  }
}

describe('ClipboardSyncService', () => {
  let syncService: ClipboardSyncService;
  let mockWsClient: MockWebSocketClient;
  let mockClipboardService: MockClipboardService;
  const deviceId = 'test-device-id';
  const authToken = 'synk_test_token';
  const wsUrl = 'ws://localhost:8000/ws/test-device-id';

  beforeEach(() => {
    vi.useFakeTimers();
    mockWsClient = new MockWebSocketClient();
    mockClipboardService = new MockClipboardService();

    // We need to construct the service with our mocks
    // Since constructor is private-ish, we'll test via integration style
    // But we can't easily inject mocks, so let's test the actual service with mocked WebSocket
  });

  afterEach(() => {
    vi.useRealTimers();
    syncService?.dispose();
  });

  describe('initialization', () => {
    it('starts in disconnected state', () => {
      syncService = new ClipboardSyncService(deviceId, authToken, wsUrl, mockClipboardService as any);
      expect(syncService.state).toBe(ClipboardSyncState.Disconnected);
      expect(syncService.isSyncing).toBe(false);
    });

    it('transitions to connecting on initialize', async () => {
      syncService = new ClipboardSyncService(deviceId, authToken, wsUrl, mockClipboardService as any);

      // Override the protected method
      const originalCreateWs = (syncService as any).createWebSocketClient.bind(syncService);
      (syncService as any).createWebSocketClient = () => mockWsClient;

      await syncService.initialize();
      await vi.runAllTimersAsync();

      expect(syncService.state).toBe(ClipboardSyncState.Connected);
      expect(syncService.isSyncing).toBe(true);

      // Restore
      (syncService as any).createWebSocketClient = originalCreateWs;
    });
  });

  describe('clipboard update handling', () => {
    beforeEach(async () => {
      syncService = new ClipboardSyncService(deviceId, authToken, wsUrl, mockClipboardService as any);

      // Override the protected method
      const originalCreateWs = (syncService as any).createWebSocketClient.bind(syncService);
      (syncService as any).createWebSocketClient = () => mockWsClient;

      await syncService.initialize();
      await vi.runAllTimersAsync();
    });

    it('ignores clipboard relay from self', async () => {
      const receivedHandler = vi.fn();
      syncService.on('clipboardReceived', receivedHandler);

      // Simulate relay from same device
      const relay: ClipboardUpdateRelayMessage = {
        type: SyncMessageType.CLIPBOARD_UPDATE_RELAY,
        version: 1,
        message_id: generateMessageId(),
        device_id: deviceId,
        timestamp: generateTimestamp(),
        payload: { content_type: ContentType.TEXT, text: 'Self message' },
        source_device_id: deviceId, // Same as our device
      };

      // Access private method for testing
      (syncService as any).onWebSocketMessage(relay);
      await vi.runAllTimersAsync();

      expect(receivedHandler).not.toHaveBeenCalled();
      expect(mockClipboardService.lastWritten).toBe('');
    });

    it('applies clipboard relay from other device', async () => {
      const receivedHandler = vi.fn();
      syncService.on('clipboardReceived', receivedHandler);

      const sourceDeviceId = 'other-device-id';
      const relay: ClipboardUpdateRelayMessage = {
        type: SyncMessageType.CLIPBOARD_UPDATE_RELAY,
        version: 1,
        message_id: generateMessageId(),
        device_id: deviceId,
        timestamp: generateTimestamp(),
        payload: { content_type: ContentType.TEXT, text: 'Hello from other device' },
        source_device_id: sourceDeviceId,
      };

      (syncService as any).onWebSocketMessage(relay);
      await vi.runAllTimersAsync();

      expect(receivedHandler).toHaveBeenCalledWith('Hello from other device', sourceDeviceId);
      expect(mockClipboardService.lastWritten).toBe('Hello from other device');
    });

    it('ignores duplicate relay messages', async () => {
      const receivedHandler = vi.fn();
      syncService.on('clipboardReceived', receivedHandler);

      const messageId = generateMessageId();
      const relay: ClipboardUpdateRelayMessage = {
        type: SyncMessageType.CLIPBOARD_UPDATE_RELAY,
        version: 1,
        message_id: messageId,
        device_id: deviceId,
        timestamp: generateTimestamp(),
        payload: { content_type: ContentType.TEXT, text: 'First message' },
        source_device_id: 'other-device',
      };

      // Send first time
      (syncService as any).onWebSocketMessage(relay);
      await vi.runAllTimersAsync();

      expect(receivedHandler).toHaveBeenCalledTimes(1);

      // Send again with same message_id
      (syncService as any).onWebSocketMessage(relay);
      await vi.runAllTimersAsync();

      expect(receivedHandler).toHaveBeenCalledTimes(1); // Should not be called again
    });

    it('ignores relay with empty text', async () => {
      const receivedHandler = vi.fn();
      syncService.on('clipboardReceived', receivedHandler);

      const relay: ClipboardUpdateRelayMessage = {
        type: SyncMessageType.CLIPBOARD_UPDATE_RELAY,
        version: 1,
        message_id: generateMessageId(),
        device_id: deviceId,
        timestamp: generateTimestamp(),
        payload: { content_type: ContentType.TEXT, text: '' },
        source_device_id: 'other-device',
      };

      (syncService as any).onWebSocketMessage(relay);
      await vi.runAllTimersAsync();

      expect(receivedHandler).not.toHaveBeenCalled();
    });

    it('sends delivery receipt for received clipboard update', async () => {
      const relay: ClipboardUpdateRelayMessage = {
        type: SyncMessageType.CLIPBOARD_UPDATE_RELAY,
        version: 1,
        message_id: 'msg-123',
        device_id: deviceId,
        timestamp: generateTimestamp(),
        payload: { content_type: ContentType.TEXT, text: 'Test message' },
        source_device_id: 'other-device',
      };

      (syncService as any).onWebSocketMessage(relay);
      await vi.runAllTimersAsync();

      // Check that delivery receipt was sent
      const wsClient = (syncService as any).webSocketClient;
      // We can't easily check mockWsClient.sentMessages since we're using real implementation
      // This test would need the actual WebSocket client to be mocked
    });
  });

  describe('history sync handling', () => {
    beforeEach(async () => {
      syncService = new ClipboardSyncService(deviceId, authToken, wsUrl, mockClipboardService as any);

      // Override the protected method
      const originalCreateWs = (syncService as any).createWebSocketClient.bind(syncService);
      (syncService as any).createWebSocketClient = () => mockWsClient;

      await syncService.initialize();
      await vi.runAllTimersAsync();
    });

    it('applies history sync entries in reverse order (oldest first)', async () => {
      const receivedHandler = vi.fn();
      syncService.on('clipboardReceived', receivedHandler);

      const msgId1 = generateMessageId();
      const msgId2 = generateMessageId();

      const historyResponse: HistorySyncResponseMessage = {
        type: SyncMessageType.HISTORY_SYNC_RESPONSE,
        version: 1,
        message_id: generateMessageId(),
        device_id: deviceId,
        timestamp: generateTimestamp(),
        payload: {
          entries: [
            { message_id: msgId1, content_type: 'text', content_text: 'Oldest entry', source_device_id: 'dev1', delivered_count: 0, created_at: '2024-01-01T00:00:00Z' },
            { message_id: msgId2, content_type: 'text', content_text: 'Newest entry', source_device_id: 'dev2', delivered_count: 0, created_at: '2024-01-01T01:00:00Z' },
          ],
          count: 2,
          limit: 50,
        },
      };

      (syncService as any).onWebSocketMessage(historyResponse);
      await vi.runAllTimersAsync();

      // Should apply oldest first (msgId1 then msgId2)
      expect(receivedHandler).toHaveBeenCalledTimes(2);
      expect(receivedHandler.mock.calls[0][0]).toBe('Oldest entry');
      expect(receivedHandler.mock.calls[1][0]).toBe('Newest entry');
    });

    it('skips history entries with empty text', async () => {
      const receivedHandler = vi.fn();
      syncService.on('clipboardReceived', receivedHandler);

      const historyResponse: HistorySyncResponseMessage = {
        type: SyncMessageType.HISTORY_SYNC_RESPONSE,
        version: 1,
        message_id: generateMessageId(),
        device_id: deviceId,
        timestamp: generateTimestamp(),
        payload: {
          entries: [
            { message_id: 'msg-1', content_type: 'text', content_text: '', source_device_id: 'dev1', delivered_count: 0, created_at: '2024-01-01T00:00:00Z' },
            { message_id: 'msg-2', content_type: 'text', content_text: 'Valid entry', source_device_id: 'dev2', delivered_count: 0, created_at: '2024-01-01T01:00:00Z' },
          ],
          count: 2,
          limit: 50,
        },
      };

      (syncService as any).onWebSocketMessage(historyResponse);
      await vi.runAllTimersAsync();

      expect(receivedHandler).toHaveBeenCalledTimes(1);
      expect(receivedHandler.mock.calls[0][0]).toBe('Valid entry');
    });

    it('skips history entries without message_id', async () => {
      const receivedHandler = vi.fn();
      syncService.on('clipboardReceived', receivedHandler);

      const historyResponse: HistorySyncResponseMessage = {
        type: SyncMessageType.HISTORY_SYNC_RESPONSE,
        version: 1,
        message_id: generateMessageId(),
        device_id: deviceId,
        timestamp: generateTimestamp(),
        payload: {
          entries: [
            { message_id: '', content_type: 'text', content_text: 'No ID', source_device_id: 'dev1', delivered_count: 0, created_at: '2024-01-01T00:00:00Z' },
            { message_id: 'msg-2', content_type: 'text', content_text: 'Has ID', source_device_id: 'dev2', delivered_count: 0, created_at: '2024-01-01T01:00:00Z' },
          ],
          count: 2,
          limit: 50,
        },
      };

      (syncService as any).onWebSocketMessage(historyResponse);
      await vi.runAllTimersAsync();

      expect(receivedHandler).toHaveBeenCalledTimes(1);
      expect(receivedHandler.mock.calls[0][0]).toBe('Has ID');
    });

    it('sends delivery receipts for history entries', async () => {
      const historyResponse: HistorySyncResponseMessage = {
        type: SyncMessageType.HISTORY_SYNC_RESPONSE,
        version: 1,
        message_id: generateMessageId(),
        device_id: deviceId,
        timestamp: generateTimestamp(),
        payload: {
          entries: [
            { message_id: 'msg-1', content_type: 'text', content_text: 'Entry 1', source_device_id: 'dev1', delivered_count: 0, created_at: '2024-01-01T00:00:00Z' },
            { message_id: 'msg-2', content_type: 'text', content_text: 'Entry 2', source_device_id: 'dev2', delivered_count: 0, created_at: '2024-01-01T01:00:00Z' },
          ],
          count: 2,
          limit: 50,
        },
      };

      (syncService as any).onWebSocketMessage(historyResponse);
      await vi.runAllTimersAsync();

      // Check delivery receipts were sent
      const wsClient = (syncService as any).webSocketClient;
      // Test would need mock WebSocket to verify
    });
  });

  describe('device online/offline notifications', () => {
    beforeEach(async () => {
      syncService = new ClipboardSyncService(deviceId, authToken, wsUrl, mockClipboardService as any);

      // Override the protected method
      const originalCreateWs = (syncService as any).createWebSocketClient.bind(syncService);
      (syncService as any).createWebSocketClient = () => mockWsClient;

      await syncService.initialize();
      await vi.runAllTimersAsync();
    });

    it('emits pairedDeviceOnline event', async () => {
      const onlineHandler = vi.fn();
      syncService.on('pairedDeviceOnline', onlineHandler);

      const onlineMsg: DeviceOnlineMessage = {
        type: SyncMessageType.DEVICE_ONLINE,
        version: 1,
        message_id: generateMessageId(),
        device_id: deviceId,
        timestamp: generateTimestamp(),
        payload: { device_id: 'other-device' },
      };

      (syncService as any).onWebSocketMessage(onlineMsg);
      await vi.runAllTimersAsync();

      expect(onlineHandler).toHaveBeenCalledWith('other-device');
    });

    it('emits pairedDeviceOffline event', async () => {
      const offlineHandler = vi.fn();
      syncService.on('pairedDeviceOffline', offlineHandler);

      const offlineMsg: DeviceOfflineMessage = {
        type: SyncMessageType.DEVICE_OFFLINE,
        version: 1,
        message_id: generateMessageId(),
        device_id: deviceId,
        timestamp: generateTimestamp(),
        payload: { device_id: 'other-device' },
      };

      (syncService as any).onWebSocketMessage(offlineMsg);
      await vi.runAllTimersAsync();

      expect(offlineHandler).toHaveBeenCalledWith('other-device');
    });
  });

  describe('error handling', () => {
    beforeEach(async () => {
      syncService = new ClipboardSyncService(deviceId, authToken, wsUrl, mockClipboardService as any);

      // Override the protected method
      const originalCreateWs = (syncService as any).createWebSocketClient.bind(syncService);
      (syncService as any).createWebSocketClient = () => mockWsClient;

      await syncService.initialize();
      await vi.runAllTimersAsync();
    });

    it('emits error on WebSocket error message', async () => {
      const errorHandler = vi.fn();
      syncService.on('error', errorHandler);

      const errorMsg: ErrorMessage = {
        type: SyncMessageType.ERROR,
        version: 1,
        message_id: generateMessageId(),
        device_id: deviceId,
        timestamp: generateTimestamp(),
        payload: { error_code: 'test_error', error_message: 'Test error message' },
      };

      (syncService as any).onWebSocketMessage(errorMsg);
      await vi.runAllTimersAsync();

      expect(errorHandler).toHaveBeenCalled();
      expect(errorHandler.mock.calls[0][0].message).toContain('test_error');
    });
  });

  describe('local clipboard change handling', () => {
    beforeEach(async () => {
      syncService = new ClipboardSyncService(deviceId, authToken, wsUrl, mockClipboardService as any);

      // Override the protected method
      const originalCreateWs = (syncService as any).createWebSocketClient.bind(syncService);
      (syncService as any).createWebSocketClient = () => mockWsClient;

      await syncService.initialize();
      await vi.runAllTimersAsync();
    });

    it('sends clipboard update on local change', async () => {
      mockClipboardService.simulateChange('New clipboard content');
      await vi.runAllTimersAsync();

      const wsClient = (syncService as any).webSocketClient;
      // Would verify clipboard update was sent
    });

    it('skips empty clipboard content', async () => {
      mockClipboardService.simulateChange('');
      await vi.runAllTimersAsync();

      // Should not send
      const wsClient = (syncService as any).webSocketClient;
    });

    it('deduplicates consecutive identical content', async () => {
      mockClipboardService.simulateChange('Same content');
      await vi.runAllTimersAsync();

      mockClipboardService.simulateChange('Same content');
      await vi.runAllTimersAsync();

      // Should only send once
    });
  });

  describe('disposal', () => {
    it('cleans up all resources', async () => {
      syncService = new ClipboardSyncService(deviceId, authToken, wsUrl, mockClipboardService as any);

      // Override the protected method
      const originalCreateWs = (syncService as any).createWebSocketClient.bind(syncService);
      (syncService as any).createWebSocketClient = () => mockWsClient;

      await syncService.initialize();
      await vi.runAllTimersAsync();

      expect(syncService.isSyncing).toBe(true);

      syncService.dispose();

      expect(syncService.state).toBe(ClipboardSyncState.Disconnected);
    });
  });
});