/**
 * Base synchronization message with common fields.
 *
 * This MUST match the backend SyncMessageBase model exactly.
 */

export interface SyncMessageBase {
  type: string;
  version: number;
  message_id: string;
  device_id: string;
  timestamp: string;
}

/** Generate current UTC timestamp in ISO 8601 format with Z suffix. */
export function generateTimestamp(): string {
  return new Date().toISOString().replace('+00:00', 'Z');
}