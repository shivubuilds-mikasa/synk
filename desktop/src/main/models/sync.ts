/**
 * Synk clipboard synchronization protocol models.
 *
 * These types MUST match the backend protocol in app/models/sync.py exactly.
 * Any mismatch will cause synchronization failures.
 */

import { SyncMessageBase, generateTimestamp } from './sync-base';

export { SyncMessageBase, generateTimestamp };

/** Content types supported for synchronization. */
export enum ContentType {
  TEXT = 'text',
  // Future: IMAGE = 'image', FILE = 'file', LINK = 'link'
}

/** Payload for clipboard synchronization messages. */
export interface ClipboardPayload {
  content_type: ContentType;
  text: string;
}

/** Message types matching backend SyncMessageType enum. */
export enum SyncMessageType {
  // Client -> Server
  CLIPBOARD_UPDATE = 'clipboard.update',
  PING = 'ping',
  DELIVERY_RECEIPT = 'delivery.receipt',
  HISTORY_SYNC_REQUEST = 'history.sync.request',

  // Server -> Client
  CLIPBOARD_UPDATE_RECEIVED = 'clipboard.update.received',
  CLIPBOARD_UPDATE_RELAY = 'clipboard.update.relay',
  PONG = 'pong',
  ERROR = 'error',
  ACK = 'ack',
  HISTORY_SYNC_RESPONSE = 'history.sync.response',
  DEVICE_ONLINE = 'device.online',
  DEVICE_OFFLINE = 'device.offline',
  AUTH_SUCCESS = 'auth.success',
}

/** Client -> Server: Clipboard content update. */
export interface ClipboardUpdateMessage extends SyncMessageBase {
  type: SyncMessageType.CLIPBOARD_UPDATE;
  payload: ClipboardPayload;
}

/** Client -> Server: Ping for connection health. */
export interface PingMessage extends SyncMessageBase {
  type: SyncMessageType.PING;
  payload?: Record<string, unknown>;
}

/** Client -> Server: Delivery receipt for clipboard update. */
export interface DeliveryReceiptMessage extends SyncMessageBase {
  type: SyncMessageType.DELIVERY_RECEIPT;
  payload: {
    received_message_id: string;
  };
}

/** Client -> Server: Request clipboard history sync. */
export interface HistorySyncRequestMessage extends SyncMessageBase {
  type: SyncMessageType.HISTORY_SYNC_REQUEST;
  payload: {
    limit?: number;
  };
}

/** Union of all client-to-server messages. */
export type ClientMessage =
  | ClipboardUpdateMessage
  | PingMessage
  | DeliveryReceiptMessage
  | HistorySyncRequestMessage;

/** Server -> Client: Acknowledgment that clipboard update was received. */
export interface ClipboardUpdateReceivedMessage extends SyncMessageBase {
  type: SyncMessageType.CLIPBOARD_UPDATE_RECEIVED;
  payload: Record<string, unknown>;
}

/** Server -> Client: Relayed clipboard update from paired device. */
export interface ClipboardUpdateRelayMessage extends SyncMessageBase {
  type: SyncMessageType.CLIPBOARD_UPDATE_RELAY;
  payload: ClipboardPayload;
  source_device_id: string;
}

/** Server -> Client: Ping response. */
export interface PongMessage extends SyncMessageBase {
  type: SyncMessageType.PONG;
  payload?: {
    original_message_id?: string;
  };
}

/** Server -> Client: Error response. */
export interface ErrorMessage extends SyncMessageBase {
  type: SyncMessageType.ERROR;
  payload: {
    error_code: string;
    error_message: string;
    original_message_id?: string;
  };
}

/** Server -> Client: Generic acknowledgment. */
export interface AckMessage extends SyncMessageBase {
  type: SyncMessageType.ACK;
  payload: {
    acknowledged_message_id: string;
    status: string;
  };
}

/** Server -> Client: Clipboard history sync response. */
export interface HistorySyncResponseMessage extends SyncMessageBase {
  type: SyncMessageType.HISTORY_SYNC_RESPONSE;
  payload: {
    entries: Array<{
      message_id: string;
      content_type: string;
      content_text: string;
      source_device_id: string | null;
      delivered_count: number;
      created_at: string | null;
    }>;
    count: number;
    limit: number;
  };
}

/** Server -> Client: Notification that a paired device came online. */
export interface DeviceOnlineMessage extends SyncMessageBase {
  type: SyncMessageType.DEVICE_ONLINE;
  payload: {
    device_id: string;
  };
}

/** Server -> Client: Notification that a paired device went offline. */
export interface DeviceOfflineMessage extends SyncMessageBase {
  type: SyncMessageType.DEVICE_OFFLINE;
  payload: {
    device_id: string;
  };
}

/** Server -> Client: Authentication success. */
export interface AuthSuccessMessage extends SyncMessageBase {
  type: SyncMessageType.AUTH_SUCCESS;
  payload?: Record<string, unknown>;
}

/** Union of all server-to-client messages. */
export type ServerMessage =
  | ClipboardUpdateReceivedMessage
  | ClipboardUpdateRelayMessage
  | PongMessage
  | ErrorMessage
  | AckMessage
  | HistorySyncResponseMessage
  | DeviceOnlineMessage
  | DeviceOfflineMessage
  | AuthSuccessMessage;

/** All possible messages. */
export type SyncMessage = ClientMessage | ServerMessage;

/** Authentication message (first message sent by client). */
export interface AuthMessage {
  type: 'auth';
  token: string;
}

/** Authentication success response from server. */
export interface AuthSuccessResponse {
  type: SyncMessageType.AUTH_SUCCESS;
  device_id: string;
  timestamp: string;
}

/** Type guard functions for message discrimination. */
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

export function isAuthSuccessMessage(msg: ServerMessage): msg is AuthSuccessMessage {
  return msg.type === SyncMessageType.AUTH_SUCCESS;
}

export function isPongMessage(msg: ServerMessage): msg is PongMessage {
  return msg.type === SyncMessageType.PONG;
}

export function isClipboardUpdateReceived(msg: ServerMessage): msg is ClipboardUpdateReceivedMessage {
  return msg.type === SyncMessageType.CLIPBOARD_UPDATE_RECEIVED;
}

/** Create a clipboard update message. */
export function createClipboardUpdateMessage(
  deviceId: string,
  text: string,
  messageId?: string
): ClipboardUpdateMessage {
  return {
    type: SyncMessageType.CLIPBOARD_UPDATE,
    version: 1,
    message_id: messageId ?? generateMessageId(),
    device_id: deviceId,
    timestamp: generateTimestamp(),
    payload: {
      content_type: ContentType.TEXT,
      text,
    },
  };
}

/** Create a delivery receipt message. */
export function createDeliveryReceiptMessage(
  deviceId: string,
  receivedMessageId: string,
  messageId?: string
): DeliveryReceiptMessage {
  return {
    type: SyncMessageType.DELIVERY_RECEIPT,
    version: 1,
    message_id: messageId ?? generateMessageId(),
    device_id: deviceId,
    timestamp: generateTimestamp(),
    payload: {
      received_message_id: receivedMessageId,
    },
  };
}

/** Create a history sync request message. */
export function createHistorySyncRequestMessage(
  deviceId: string,
  limit: number = 50,
  messageId?: string
): HistorySyncRequestMessage {
  return {
    type: SyncMessageType.HISTORY_SYNC_REQUEST,
    version: 1,
    message_id: messageId ?? generateMessageId(),
    device_id: deviceId,
    timestamp: generateTimestamp(),
    payload: {
      limit,
    },
  };
}

/** Create a ping message. */
export function createPingMessage(deviceId: string, messageId?: string): PingMessage {
  return {
    type: SyncMessageType.PING,
    version: 1,
    message_id: messageId ?? generateMessageId(),
    device_id: deviceId,
    timestamp: generateTimestamp(),
    payload: undefined,
  };
}

/** Generate a unique message ID using timestamp + random. */
export function generateMessageId(): string {
  return (
    Date.now().toString(36) + Math.random().toString(36).substring(2, 10)
  );
}

/** Parse a raw JSON string into a ServerMessage. */
export function parseServerMessage(raw: string): ServerMessage {
  const data = JSON.parse(raw);
  const type = data.type as SyncMessageType;

  switch (type) {
    case SyncMessageType.CLIPBOARD_UPDATE_RELAY:
      return data as ClipboardUpdateRelayMessage;
    case SyncMessageType.ERROR:
      return data as ErrorMessage;
    case SyncMessageType.ACK:
      return data as AckMessage;
    case SyncMessageType.HISTORY_SYNC_RESPONSE:
      return data as HistorySyncResponseMessage;
    case SyncMessageType.DEVICE_ONLINE:
      return data as DeviceOnlineMessage;
    case SyncMessageType.DEVICE_OFFLINE:
      return data as DeviceOfflineMessage;
    case SyncMessageType.AUTH_SUCCESS:
      return data as AuthSuccessMessage;
    case SyncMessageType.PONG:
      return data as PongMessage;
    case SyncMessageType.CLIPBOARD_UPDATE_RECEIVED:
      return data as ClipboardUpdateReceivedMessage;
    default:
      throw new Error(`Unknown server message type: ${type}`);
  }
}

/** Parse a raw JSON string into a ClientMessage. */
export function parseClientMessage(raw: string): ClientMessage {
  const data = JSON.parse(raw);
  const type = data.type as SyncMessageType;

  switch (type) {
    case SyncMessageType.CLIPBOARD_UPDATE:
      return data as ClipboardUpdateMessage;
    case SyncMessageType.PING:
      return data as PingMessage;
    case SyncMessageType.DELIVERY_RECEIPT:
      return data as DeliveryReceiptMessage;
    case SyncMessageType.HISTORY_SYNC_REQUEST:
      return data as HistorySyncRequestMessage;
    default:
      throw new Error(`Unknown client message type: ${type}`);
  }
}