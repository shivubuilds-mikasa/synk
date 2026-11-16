/**
 * Synk Desktop configuration.
 *
 * All environment-specific configuration is centralized here.
 * Never hardcode URLs or secrets elsewhere in the codebase.
 */

interface AppConfig {
  /** Backend API base URL. Default: the hosted Synk test backend. */
  backendUrl: string;
  /** Device name to use during registration. */
  deviceName: string;
  /** Request timeout in milliseconds. */
  requestTimeoutMs: number;
  /** Secure storage service name. */
  storageServiceName: string;
  /** Secure storage account name. */
  storageAccountName: string;
}

/**
 * Get application configuration.
 * Development defaults are provided; override via environment variables if needed.
 */
export function getConfig(): AppConfig {
  const backendUrl = process.env.SYNK_BACKEND_URL ?? 'https://synk-api-vb4q.onrender.com';
  const isRenderBackend = new URL(backendUrl).hostname.endsWith('.onrender.com');
  return {
    backendUrl: backendUrl.replace(/\/$/, ''), // Strip trailing slash
    deviceName: process.env.SYNK_DEVICE_NAME ?? getDefaultDeviceName(),
    requestTimeoutMs: Number(
      process.env.SYNK_REQUEST_TIMEOUT_MS ?? (isRenderBackend ? 65000 : 10000),
    ),
    storageServiceName: 'synk-desktop',
    storageAccountName: 'synk-credentials',
  };
}

/**
 * Get default device name using OS hostname and platform.
 * Exported for testing.
 */
export function getDefaultDeviceName(): string {
  // Use OS hostname + platform for a sensible default
  const os = require('os');
  const hostname = os.hostname();
  const platform = os.platform(); // 'win32', 'darwin', 'linux'
  return `Synk Desktop (${hostname}, ${platform})`;
}

export const config = getConfig();
