/**
 * WebSocket client for Synk desktop.
 *
 * Provides a robust WebSocket connection to the Synk backend with:
 * - Authentication handshake
 * - Automatic reconnection with exponential backoff
 * - Connection state management
 * - Message parsing and dispatch
 * - Graceful disposal
 */

import { EventEmitter } from 'events';
import WebSocket from 'ws';
import {
  SyncMessageType,
  ContentType,
  ClipboardPayload,
  ClientMessage,
  ServerMessage,
  ClipboardUpdateMessage,
  PingMessage,
  DeliveryReceiptMessage,
  HistorySyncRequestMessage,
  ClipboardUpdateRelayMessage,
  ErrorMessage,
  AckMessage,
  HistorySyncResponseMessage,
  DeviceOnlineMessage,
  DeviceOfflineMessage,
  AuthSuccessMessage,
  ClipboardUpdateReceivedMessage,
  PongMessage,
  parseServerMessage,
  generateMessageId,
  generateTimestamp,
} from '../models/sync';
import { SyncMessageBase } from '../models/sync-base';

/** Connection state of the WebSocket client. */
export enum WebSocketConnectionState {
  Disconnected = 'disconnected',
  Connecting = 'connecting',
  Connected = 'connected',
  Reconnecting = 'reconnecting',
  Error = 'error',
}

/** Configuration for WebSocket client behavior. */
export interface WebSocketClientConfig {
  /** Initial reconnection delay in milliseconds. */
  initialReconnectDelayMs: number;
  /** Maximum reconnection delay in milliseconds. */
  maxReconnectDelayMs: number;
  /** Multiplier for exponential backoff. */
  backoffMultiplier: number;
  /** Jitter factor (0.0 to 1.0) to prevent thundering herd. */
  jitterFactor: number;
  /** Ping interval in milliseconds. */
  pingIntervalMs: number;
  /** Connection timeout in milliseconds. */
  connectionTimeoutMs: number;
  /** Maximum message size in bytes. */
  maxMessageSizeBytes: number;
}

/** Default configuration. */
export const DEFAULT_CONFIG: WebSocketClientConfig = {
  initialReconnectDelayMs: 1000,
  maxReconnectDelayMs: 30000,
  backoffMultiplier: 2.0,
  jitterFactor: 0.3,
  pingIntervalMs: 30000,
  connectionTimeoutMs: 10000,
  maxMessageSizeBytes: 200000,
};

/** Events emitted by the WebSocket client. */
export interface SynkWebSocketClientEvents {
  stateChange: [state: WebSocketConnectionState];
  message: [message: ServerMessage];
  error: [error: Error];
}

/**
 * WebSocket client for Synk backend.
 *
 * Handles connection lifecycle, authentication, message parsing,
 * and automatic reconnection with exponential backoff.
 */
export class SynkWebSocketClient extends EventEmitter<SynkWebSocketClientEvents> {
  private readonly wsUrl: string;
  private readonly deviceId: string;
  private readonly config: WebSocketClientConfig;

  private ws: WebSocket | null = null;
  private reconnectTimer: NodeJS.Timeout | null = null;
  private pingTimer: NodeJS.Timeout | null = null;
  private connectionTimeoutTimer: NodeJS.Timeout | null = null;

  private state: WebSocketConnectionState = WebSocketConnectionState.Disconnected;
  private reconnectAttempts = 0;
  private disposed = false;
  private authenticated = false;
  private lastError: string | null = null;

  /**
   * Creates a new WebSocket client.
   *
   * @param wsUrl - WebSocket endpoint URL (e.g., ws://10.0.2.2:8000/api/v1/ws/{device_id})
   * @param deviceId - Device ID for authentication
   * @param authToken - Authentication token for handshake (sent in first message body)
   * @param config - Optional configuration for reconnection and ping behavior
   */
  constructor(
    wsUrl: string,
    deviceId: string,
    private readonly authToken: string,
    config?: Partial<WebSocketClientConfig>
  ) {
    super();
    this.wsUrl = wsUrl;
    this.deviceId = deviceId;
    this.config = { ...DEFAULT_CONFIG, ...config };
  }

  /** Current connection state. */
  get connectionState(): WebSocketConnectionState {
    return this.state;
  }

  /** Whether the client is currently connected and authenticated. */
  get isConnected(): boolean {
    return this.state === WebSocketConnectionState.Connected && this.authenticated;
  }

  /** Last error message if any. */
  get lastErrorMessage(): string | null {
    return this.lastError;
  }

  /** Device ID for this connection. */
  get deviceIdGetter(): string {
    return this.deviceId;
  }

  /**
   * Connects to the WebSocket server and performs authentication.
   */
  async connect(): Promise<void> {
    if (this.disposed) return;
    if (
      this.state === WebSocketConnectionState.Connecting ||
      this.state === WebSocketConnectionState.Connected
    ) {
      return;
    }

    this.setState(WebSocketConnectionState.Connecting);
    this.authenticated = false;

    try {
      this.ws = new WebSocket(this.wsUrl);

      // Set up connection timeout
      this.connectionTimeoutTimer = setTimeout(() => {
        if (!this.authenticated && this.state === WebSocketConnectionState.Connecting) {
          this.handleConnectionError(
            new Error('Connection timeout during authentication')
          );
        }
      }, this.config.connectionTimeoutMs);

      // Listen for events
      this.ws.on('open', () => this.onOpen());
      this.ws.on('message', (data: Buffer) => this.onMessage(data));
      this.ws.on('error', (error: Error) => this.onError(error));
      this.ws.on('close', (code: number, reason: Buffer) =>
        this.onClose(code, reason.toString())
      );
    } catch (error) {
      this.handleConnectionError(error as Error);
    }
  }

  /**
   * Disconnects gracefully.
   */
  async disconnect(): Promise<void> {
    this.cancelReconnect();
    this.cancelPingTimer();
    this.cancelConnectionTimeout();

    // Set state to Disconnected BEFORE closing WebSocket to prevent onClose from scheduling reconnect
    this.authenticated = false;
    this.setState(WebSocketConnectionState.Disconnected);

    if (this.ws) {
      this.ws.close(1000, 'Normal closure');
      this.ws = null;
    }
  }

  /**
   * Sends a client message to the server.
   *
   * @returns true if the message was sent successfully
   */
  async send(message: ClientMessage): Promise<boolean> {
    if (!this.isConnected || !this.ws) {
      return false;
    }

    try {
      const json = JSON.stringify(message);
      if (json.length > this.config.maxMessageSizeBytes) {
        return false;
      }
      this.ws.send(json);
      return true;
    } catch (error) {
      this.handleError(error as Error);
      return false;
    }
  }

  /**
   * Sends a clipboard update message.
   */
  async sendClipboardUpdate(
    messageId: string,
    text: string,
    contentType: ContentType = ContentType.TEXT
  ): Promise<boolean> {
    const message: ClipboardUpdateMessage = {
      type: SyncMessageType.CLIPBOARD_UPDATE,
      version: 1,
      message_id: messageId,
      device_id: this.deviceId,
      timestamp: generateTimestamp(),
      payload: {
        content_type: contentType,
        text,
      },
    };
    return this.send(message);
  }

  /**
   * Sends a delivery receipt for a received clipboard update.
   */
  async sendDeliveryReceipt(
    messageId: string,
    receivedMessageId: string
  ): Promise<boolean> {
    const message: DeliveryReceiptMessage = {
      type: SyncMessageType.DELIVERY_RECEIPT,
      version: 1,
      message_id: messageId,
      device_id: this.deviceId,
      timestamp: generateTimestamp(),
      payload: {
        received_message_id: receivedMessageId,
      },
    };
    return this.send(message);
  }

  /**
   * Sends a history sync request.
   */
  async sendHistorySyncRequest(
    messageId: string,
    limit: number = 50
  ): Promise<boolean> {
    const message: HistorySyncRequestMessage = {
      type: SyncMessageType.HISTORY_SYNC_REQUEST,
      version: 1,
      message_id: messageId,
      device_id: this.deviceId,
      timestamp: generateTimestamp(),
      payload: {
        limit,
      },
    };
    return this.send(message);
  }

  /**
   * Sends a ping message.
   */
  async sendPing(messageId?: string): Promise<boolean> {
    const message: PingMessage = {
      type: SyncMessageType.PING,
      version: 1,
      message_id: messageId ?? generateMessageId(),
      device_id: this.deviceId,
      timestamp: generateTimestamp(),
      payload: undefined,
    };
    return this.send(message);
  }

  /**
   * Disposes all resources.
   */
  dispose(): void {
    this.disposed = true;
    this.disconnect();
    this.removeAllListeners();
  }

  private setState(newState: WebSocketConnectionState): void {
    if (this.state !== newState) {
      this.state = newState;
      this.emit('stateChange', newState);
    }
  }

  private onOpen(): void {
    if (this.disposed) return;

    // Send authentication message as first message
    const authMessage = {
      type: 'auth',
      token: this.authToken,
    };
    this.ws?.send(JSON.stringify(authMessage));
  }

  private onMessage(data: Buffer): void {
    if (this.disposed) return;

    const messageStr = data.toString();
    if (messageStr.length > this.config.maxMessageSizeBytes) {
      return;
    }

    try {
      const serverMessage = parseServerMessage(messageStr);

      // Handle authentication success
      if (isAuthSuccessMessage(serverMessage)) {
        this.authenticated = true;
        this.cancelConnectionTimeout();
        this.startPingTimer();
        this.setState(WebSocketConnectionState.Connected);
        this.reconnectAttempts = 0;
      }

      this.emit('message', serverMessage);
    } catch (error) {
      this.handleError(
        new Error(`Failed to parse WebSocket message: ${error}`)
      );
    }
  }

  private onError(error: Error): void {
    if (this.disposed) return;
    // WebSocket errors are connection errors - handle them as such
    this.handleConnectionError(error);
  }

  private onClose(code: number, reason: string): void {
    if (this.disposed) return;

    this.cancelConnectionTimeout();
    this.cancelPingTimer();
    this.authenticated = false;

    // Don't schedule reconnect if we're already in Error state (connection error already scheduled one)
    // Or if we're explicitly disconnecting (state = Disconnected)
    if (this.state !== WebSocketConnectionState.Disconnected &&
        this.state !== WebSocketConnectionState.Error) {
      this.setState(WebSocketConnectionState.Disconnected);
      this.scheduleReconnect();
    } else if (this.state === WebSocketConnectionState.Error) {
      // Already in error state, just update to Disconnected but don't schedule another reconnect
      this.setState(WebSocketConnectionState.Disconnected);
    }
  }

  private handleConnectionError(error: Error): void {
    if (this.disposed) return;

    this.lastError = error.message;
    this.cancelConnectionTimeout();
    this.setState(WebSocketConnectionState.Error);
    this.emit('error', error);

    if (this.ws) {
      this.ws.close(1006, 'Abnormal closure');
      this.ws = null;
    }
    // Reconnect will be scheduled in onClose when the WebSocket actually closes
  }

  private handleError(error: Error): void {
    if (this.disposed) return;
    this.lastError = error.message;
    this.emit('error', error);
  }

  private scheduleReconnect(): void {
    if (this.disposed) return;
    if (this.state === WebSocketConnectionState.Reconnecting) return;

    this.setState(WebSocketConnectionState.Reconnecting);

    // Calculate delay with exponential backoff and jitter
    const baseDelay = Math.min(
      this.config.initialReconnectDelayMs *
        Math.pow(this.config.backoffMultiplier, this.reconnectAttempts),
      this.config.maxReconnectDelayMs
    );

    const jitter = Math.floor(
      baseDelay * this.config.jitterFactor * Math.random()
    );
    const delay = baseDelay + jitter;

    this.reconnectAttempts++;
    console.log(
      `Scheduling WebSocket reconnect in ${delay}ms (attempt ${this.reconnectAttempts})`
    );

    this.reconnectTimer = setTimeout(() => {
      if (!this.disposed) {
        this.connect();
      }
    }, delay);
  }

  private startPingTimer(): void {
    this.cancelPingTimer();
    this.pingTimer = setInterval(() => {
      if (this.disposed) return;
      if (this.isConnected) {
        this.sendPing();
      }
    }, this.config.pingIntervalMs);
  }

  private cancelPingTimer(): void {
    if (this.pingTimer) {
      clearInterval(this.pingTimer);
      this.pingTimer = null;
    }
  }

  private cancelConnectionTimeout(): void {
    if (this.connectionTimeoutTimer) {
      clearTimeout(this.connectionTimeoutTimer);
      this.connectionTimeoutTimer = null;
    }
  }

  private cancelReconnect(): void {
    if (this.reconnectTimer) {
      clearTimeout(this.reconnectTimer);
      this.reconnectTimer = null;
    }
  }
}

/** Type guard functions for message discrimination. */
export function isAuthSuccessMessage(msg: ServerMessage): msg is AuthSuccessMessage {
  return msg.type === SyncMessageType.AUTH_SUCCESS;
}

export function isClipboardUpdateRelay(msg: ServerMessage): msg is ClipboardUpdateRelayMessage {
  return msg.type === SyncMessageType.CLIPBOARD_UPDATE_RELAY;
}

export function isErrorMessage(msg: ServerMessage): msg is ErrorMessage {
  return msg.type === SyncMessageType.ERROR;
}

export function isAckMessage(msg: ServerMessage): msg is AckMessage {
  return msg.type === SyncMessageType.ACK;
}

export function isHistorySyncResponse(msg: ServerMessage): msg is HistorySyncResponseMessage {
  return msg.type === SyncMessageType.HISTORY_SYNC_RESPONSE;
}

export function isDeviceOnlineMessage(msg: ServerMessage): msg is DeviceOnlineMessage {
  return msg.type === SyncMessageType.DEVICE_ONLINE;
}

export function isDeviceOfflineMessage(msg: ServerMessage): msg is DeviceOfflineMessage {
  return msg.type === SyncMessageType.DEVICE_OFFLINE;
}

export function isPongMessage(msg: ServerMessage): msg is PongMessage {
  return msg.type === SyncMessageType.PONG;
}

export function isClipboardUpdateReceived(msg: ServerMessage): msg is ClipboardUpdateReceivedMessage {
  return msg.type === SyncMessageType.CLIPBOARD_UPDATE_RECEIVED;
}