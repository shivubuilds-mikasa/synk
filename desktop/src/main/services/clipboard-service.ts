/**
 * Clipboard service for Synk desktop.
 *
 * Provides cross-platform clipboard access with change detection.
 * Uses Electron's clipboard API for native clipboard operations.
 */

import { EventEmitter } from 'events';
import { clipboard } from 'electron';

/** Events emitted by the clipboard service. */
export interface ClipboardServiceEvents {
  change: [text: string];
  error: [error: Error];
}

/**
 * Clipboard service for desktop.
 *
 * Monitors the system clipboard for changes and provides read/write operations.
 */
export class ClipboardService extends EventEmitter<ClipboardServiceEvents> {
  private pollTimer: NodeJS.Timeout | null = null;
  private lastContent = '';
  private readonly pollIntervalMs: number;
  private disposed = false;

  /**
   * Creates a clipboard service.
   *
   * @param pollIntervalMs - Polling interval in milliseconds (default: 1000)
   */
  constructor(pollIntervalMs: number = 1000) {
    super();
    this.pollIntervalMs = pollIntervalMs;
    this.lastContent = this.read() || '';
  }

  /** Last read clipboard value (for loop prevention). */
  get lastReadValue(): string {
    return this.lastContent;
  }

  /**
   * Reads the current clipboard text content.
   *
   * @returns The clipboard text, or empty string if not text
   */
  read(): string {
    try {
      const text = clipboard.readText();
      this.lastContent = text;
      return text;
    } catch (error) {
      this.emit('error', error as Error);
      return '';
    }
  }

  /**
   * Writes text to the clipboard.
   *
   * @param text - Text to write
   * @param markAsLast - Whether to update lastContent to prevent loop detection
   */
  write(text: string, markAsLast: boolean = true): void {
    try {
      clipboard.writeText(text);
      if (markAsLast) {
        this.lastContent = text;
      }
    } catch (error) {
      this.emit('error', error as Error);
    }
  }

  /**
   * Checks if clipboard contains text.
   *
   * @returns true if clipboard has text content
   */
  hasText(): boolean {
    return clipboard.readText().length > 0;
  }

  /**
   * Clears the clipboard.
   */
  clear(): void {
    clipboard.clear();
    this.lastContent = '';
  }

  /**
   * Starts polling for clipboard changes.
   */
  startPolling(): void {
    if (this.disposed || this.pollTimer) return;

    this.pollTimer = setInterval(() => {
      this.checkForChanges();
    }, this.pollIntervalMs);
  }

  /**
   * Stops polling for clipboard changes.
   */
  stopPolling(): void {
    if (this.pollTimer) {
      clearInterval(this.pollTimer);
      this.pollTimer = null;
    }
  }

  /**
   * Checks for clipboard changes and emits event if changed.
   */
  private checkForChanges(): void {
    if (this.disposed) return;

    const currentContent = this.read();
    if (currentContent && currentContent !== this.lastContent) {
      this.lastContent = currentContent;
      this.emit('change', currentContent);
    }
  }

  /**
   * Disposes all resources.
   */
  dispose(): void {
    this.disposed = true;
    this.stopPolling();
    this.removeAllListeners();
  }
}