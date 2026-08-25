/**
 * Secure credential storage using keytar.
 *
 * keytar uses the OS native secure storage:
 * - Windows: Credential Manager
 * - macOS: Keychain
 * - Linux: Secret Service (libsecret)
 *
 * This avoids storing auth tokens in plain text files.
 */

import * as keytar from 'keytar';
import { config } from '../config';
import { DeviceCredentials } from '../models/device';

/** Storage key for device credentials. */
const CREDENTIALS_KEY = 'device-credentials';

/**
 * Secure storage service for device credentials.
 * All methods throw on failure (caller handles errors).
 */
export class SecureStorage {
  private serviceName: string;
  private accountName: string;

  constructor(serviceName?: string, accountName?: string) {
    this.serviceName = serviceName ?? config.storageServiceName;
    this.accountName = accountName ?? config.storageAccountName;
  }

  /**
   * Store device credentials securely.
   * Serializes credentials to JSON and stores in OS keychain.
   */
  async storeCredentials(credentials: DeviceCredentials): Promise<void> {
    const json = JSON.stringify(credentials);
    await keytar.setPassword(this.serviceName, this.accountName, json);
  }

  /**
   * Retrieve stored device credentials.
   * Returns null if no credentials exist.
   */
  async getCredentials(): Promise<DeviceCredentials | null> {
    const json = await keytar.getPassword(this.serviceName, this.accountName);
    if (!json) {
      return null;
    }
    try {
      const parsed = JSON.parse(json);
      // Validate structure
      if (!parsed.deviceId || !parsed.deviceName || !parsed.deviceType || !parsed.authToken) {
        return null;
      }
      return parsed as DeviceCredentials;
    } catch {
      return null;
    }
  }

  /**
   * Delete stored device credentials.
   */
  async deleteCredentials(): Promise<void> {
    await keytar.deletePassword(this.serviceName, this.accountName);
  }

  /**
   * Check if credentials exist.
   */
  async hasCredentials(): Promise<boolean> {
    const json = await keytar.getPassword(this.serviceName, this.accountName);
    return !!json;
  }
}

/** Default secure storage instance. */
export const secureStorage = new SecureStorage();