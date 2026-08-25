/**
 * Clipboard synchronization service for Synk desktop.
 *
 * Orchestrates the clipboard synchronization flow:
 * - Monitors local clipboard changes
 * - Sends updates via WebSocket
 * - Receives updates from paired devices
 * - Applies updates to local clipboard
 * - Handles delivery receipts and deduplication
 */

import { EventEmitter } from 'events';
import {
  SynkWebSocketClient,
  WebSocketConnectionState,
} from './websocket-client';
import { ClipboardPayload } from '../models/sync';
import { ClipboardService } from './clipboard-service';
import {
  SyncMessageType,
  ServerMessage,
  ClipboardUpdateRelayMessage,
  ErrorMessage,
  AckMessage,
  HistorySyncResponseMessage,
  DeviceOnlineMessage,
  DeviceOfflineMessage,
  AuthSuccessMessage,
  ClipboardUpdateReceivedMessage,
  PongMessage,
  generateMessageId,
} from '../models/sync';
import { generateTimestamp } from '../models/sync-base';

/** Synchronization state for UI display. */
export enum ClipboardSyncState {
  Disconnected = 'disconnected',
  Connecting = 'connecting',
  Connected = 'connected',
  Reconnecting = 'reconnecting',
  Error = 'error',
}

/** Events emitted by the clipboard sync service. */
export interface ClipboardSyncServiceEvents {
  stateChange: [state: ClipboardSyncState];
  clipboardReceived: [text: string, sourceDeviceId: string];
  error: [error: Error];
  pairedDeviceOnline: [deviceId: string];
  pairedDeviceOffline: [deviceId: string];
}

/**
 * Clipboard synchronization service.
 *
 * Coordinates between the WebSocket client and system clipboard
 * to achieve cross-device clipboard synchronization.
 */
export class ClipboardSyncService extends EventEmitter<ClipboardSyncServiceEvents> {
  private webSocketClient: SynkWebSocketClient | null = null;
  private clipboardService: ClipboardService;

  private syncState: ClipboardSyncState = ClipboardSyncState.Disconnected;
  private lastSentContent = '';
  private lastReceivedMessageId: string | null = null;
  private historySyncTimer: NodeJS.Timeout | null = null;
  private deviceId: string;
  private authToken: string;
  private wsUrl: string;

  /**
   * Current synchronization state.
   */
  get state(): ClipboardSyncState {
    return this.syncState;
  }

  /** Whether currently connected and syncing. */
  get isSyncing(): boolean {
    return this.syncState === ClipboardSyncState.Connected;
  }

  /**
   * Creates a clipboard sync service.
   *
   * @param deviceId - Device ID for authentication
   * @param authToken - Authentication token
   * @param wsUrl - WebSocket URL (e.g., ws://localhost:8000/api/v1/ws/)
   * @param clipboardService - Clipboard service instance
   */
  constructor(
    deviceId: string,
    authToken: string,
    wsUrl: string,
    clipboardService?: ClipboardService
  ) {
    super();
    this.deviceId = deviceId;
    this.authToken = authToken;
    this.wsUrl = wsUrl;
    this.clipboardService = clipboardService ?? new ClipboardService();
  }

  /**
   * Initializes and starts the synchronization service.
   *
   * Creates WebSocket client, sets up listeners, starts clipboard monitoring,
   * and connects to the WebSocket server.
   */
  async initialize(): Promise<void> {
    // Create WebSocket client (protected method for testability)
    this.webSocketClient = this.createWebSocketClient();

    // Set up WebSocket listeners
    this.webSocketClient.on('stateChange', this.onWebSocketStateChange.bind(this));
    this.webSocketClient.on('message', this.onWebSocketMessage.bind(this));
    this.webSocketClient.on('error', this.onWebSocketError.bind(this));

    // Set up clipboard service listener
    this.clipboardService.on('change', this.onLocalClipboardChange.bind(this));
    this.clipboardService.on('error', (error) => this.emit('error', error));

    // Read initial clipboard value
    this.clipboardService.read();

    // Start clipboard monitoring
    this.clipboardService.startPolling();

    // Connect to WebSocket
    await this.webSocketClient.connect();
  }

  /**
   * Creates the WebSocket client.
   * Protected for testability - can be overridden in tests.
   */
  protected createWebSocketClient(): SynkWebSocketClient {
    return new SynkWebSocketClient(
      `${this.wsUrl}${this.deviceId}`,
      this.deviceId,
      this.authToken
    );
  }

  /**
   * Requests a history sync from the server.
   *
   * @param limit - Maximum number of history entries to request
   */
  async requestHistorySync(limit: number = 50): Promise<void> {
    if (!this.isSyncing || !this.webSocketClient) return;

    const messageId = generateMessageId();
    await this.webSocketClient.sendHistorySyncRequest(messageId, limit);
  }

  /**
   * Disposes all resources.
   */
  dispose(): void {
    this.webSocketClient?.dispose();
    this.clipboardService.dispose();
    if (this.historySyncTimer) {
      clearTimeout(this.historySyncTimer);
      this.historySyncTimer = null;
    }
    this.removeAllListeners();
  }

  private onWebSocketStateChange(state: WebSocketConnectionState): void {
    let newSyncState: ClipboardSyncState;

    switch (state) {
      case WebSocketConnectionState.Disconnected:
        newSyncState = ClipboardSyncState.Disconnected;
        break;
      case WebSocketConnectionState.Connecting:
        newSyncState = ClipboardSyncState.Connecting;
        break;
      case WebSocketConnectionState.Connected:
        newSyncState = ClipboardSyncState.Connected;
        // Request history sync on first connect
        this.requestInitialHistorySync();
        break;
      case WebSocketConnectionState.Reconnecting:
        newSyncState = ClipboardSyncState.Reconnecting;
        break;
      case WebSocketConnectionState.Error:
        newSyncState = ClipboardSyncState.Error;
        break;
    }

    if (this.syncState !== newSyncState) {
      this.syncState = newSyncState;
      this.emit('stateChange', newSyncState);
    }
  }

  private requestInitialHistorySync(): void {
    // Request history sync after a brief delay to ensure connection is stable
    setTimeout(() => {
      if (this.isSyncing) {
        this.requestHistorySync(20);
      }
    }, 500);
  }

  private onWebSocketMessage(message: ServerMessage): void {
    try {
      switch (message.type) {
        case SyncMessageType.CLIPBOARD_UPDATE_RECEIVED:
          this.handleClipboardUpdateReceived(message as ClipboardUpdateReceivedMessage);
          break;
        case SyncMessageType.CLIPBOARD_UPDATE_RELAY:
          this.handleIncomingClipboardUpdate(message as ClipboardUpdateRelayMessage);
          break;
        case SyncMessageType.PONG:
          // Ping response - connection is healthy
          break;
        case SyncMessageType.ERROR:
          this.handleError(message as ErrorMessage);
          break;
        case SyncMessageType.ACK:
          this.handleAck(message as AckMessage);
          break;
        case SyncMessageType.HISTORY_SYNC_RESPONSE:
          this.handleHistorySyncResponse(message as HistorySyncResponseMessage);
          break;
        case SyncMessageType.DEVICE_ONLINE:
          this.handleDeviceOnline(message as DeviceOnlineMessage);
          break;
        case SyncMessageType.DEVICE_OFFLINE:
          this.handleDeviceOffline(message as DeviceOfflineMessage);
          break;
        case SyncMessageType.AUTH_SUCCESS:
          break;
        default:
          // Unknown message type - ignore silently
      }
    } catch (error) {
      this.emit('error', error instanceof Error ? error : new Error(String(error)));
    }
  }

  private handleClipboardUpdateReceived(message: ClipboardUpdateReceivedMessage): void {
    // Acknowledgment of our sent clipboard update
  }

  private handleIncomingClipboardUpdate(message: ClipboardUpdateRelayMessage): void {
    // Ignore messages originating from this device (loop prevention)
    if (message.source_device_id === this.deviceId) {
      return;
    }

    // Check for duplicate
    if (message.message_id === this.lastReceivedMessageId) {
      return;
    }

    // Apply to local clipboard
    const text = message.payload.text;
    if (!text) {
      return;
    }

    this.lastReceivedMessageId = message.message_id;
    this.clipboardService.write(text, false);
    this.emit('clipboardReceived', text, message.source_device_id);

    // Send delivery receipt
    this.sendDeliveryReceipt(message.message_id);
  }

  private async sendDeliveryReceipt(receivedMessageId: string): Promise<void> {
    const messageId = generateMessageId();
    await this.webSocketClient?.sendDeliveryReceipt(messageId, receivedMessageId);
  }

  private handleHistorySyncResponse(message: HistorySyncResponseMessage): void {
    const entries = message.payload.entries;
    if (entries && entries.length > 0) {
      // Apply entries in order (oldest first - server sends newest first, so we iterate in order)
      for (const entry of entries) {
        const text = entry.content_text;
        const messageId = entry.message_id;

        if (!text || text.length === 0) {
          continue;
        }
        if (!messageId) {
          continue;
        }

        // Only apply if newer than what we have
        if (messageId !== this.lastReceivedMessageId) {
          this.clipboardService.write(text, false);
          this.emit('clipboardReceived', text, entry.source_device_id ?? 'unknown');
          this.lastReceivedMessageId = messageId;
          // Send delivery receipt for synced entries
          this.sendDeliveryReceipt(messageId);
        }
      }
    }
  }

  private handleError(message: ErrorMessage): void {
    const errorCode = message.payload.error_code;
    const errorMessage = message.payload.error_message;
    this.emit('error', new Error(`${errorCode}: ${errorMessage}`));
  }

  private handleAck(message: AckMessage): void {
    // Generic acknowledgment - no action needed
  }

  private handleDeviceOnline(message: DeviceOnlineMessage): void {
    const deviceId = message.payload.device_id;
    this.emit('pairedDeviceOnline', deviceId);
  }

  private handleDeviceOffline(message: DeviceOfflineMessage): void {
    const deviceId = message.payload.device_id;
    this.emit('pairedDeviceOffline', deviceId);
  }

  private onWebSocketError(error: Error): void {
    this.emit('error', error);
  }

  private async onLocalClipboardChange(text: string): Promise<void> {
    // Skip empty content
    if (!text || text.trim().length === 0) return;

    // Skip if same as last sent (deduplication)
    if (text === this.lastSentContent) {
      return;
    }

    // Skip if this was recently received from another device (loop prevention)
    // This is a simple heuristic - in practice, the backend also prevents loops
    if (text === this.clipboardService.lastReadValue && this.lastReceivedMessageId) {
      // Might be a loop, but let backend handle deduplication
    }

    this.lastSentContent = text;

    // Send clipboard update
    const messageId = generateMessageId();
    await this.webSocketClient?.sendClipboardUpdate(messageId, text);
  }
}