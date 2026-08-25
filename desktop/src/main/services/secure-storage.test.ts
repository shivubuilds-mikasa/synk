/** Tests for secure storage service. */

import { describe, it, expect, beforeEach, vi } from 'vitest';
import { SecureStorage } from './secure-storage';
import { DeviceCredentials, DeviceType } from '../models/device';

// Mock keytar
vi.mock('keytar', () => ({
  setPassword: vi.fn(),
  getPassword: vi.fn(),
  deletePassword: vi.fn(),
}));

import * as keytar from 'keytar';

describe('SecureStorage', () => {
  let storage: SecureStorage;

  beforeEach(() => {
    vi.clearAllMocks();
    storage = new SecureStorage('test-service', 'test-account');
  });

  describe('storeCredentials', () => {
    it('serializes credentials to JSON and calls keytar.setPassword', async () => {
      const credentials: DeviceCredentials = {
        deviceId: 'id-1',
        deviceName: 'Test Device',
        deviceType: DeviceType.DESKTOP,
        authToken: 'synk_secret_token',
      };
      (keytar.setPassword as any).mockResolvedValueOnce(undefined);

      await storage.storeCredentials(credentials);

      expect(keytar.setPassword).toHaveBeenCalledWith(
        'test-service',
        'test-account',
        JSON.stringify(credentials),
      );
    });
  });

  describe('getCredentials', () => {
    it('returns parsed credentials when stored', async () => {
      const credentials: DeviceCredentials = {
        deviceId: 'id-1',
        deviceName: 'Test Device',
        deviceType: DeviceType.DESKTOP,
        authToken: 'synk_secret_token',
      };
      (keytar.getPassword as any).mockResolvedValueOnce(JSON.stringify(credentials));

      const result = await storage.getCredentials();

      expect(result).toEqual(credentials);
    });

    it('returns null when no credentials stored', async () => {
      (keytar.getPassword as any).mockResolvedValueOnce(null);

      const result = await storage.getCredentials();

      expect(result).toBeNull();
    });

    it('returns null when stored data is invalid JSON', async () => {
      (keytar.getPassword as any).mockResolvedValueOnce('not valid json');

      const result = await storage.getCredentials();

      expect(result).toBeNull();
    });

    it('returns null when stored data is missing required fields', async () => {
      (keytar.getPassword as any).mockResolvedValueOnce(JSON.stringify({ deviceId: 'id-1' }));

      const result = await storage.getCredentials();

      expect(result).toBeNull();
    });
  });

  describe('deleteCredentials', () => {
    it('calls keytar.deletePassword', async () => {
      (keytar.deletePassword as any).mockResolvedValueOnce(undefined);

      await storage.deleteCredentials();

      expect(keytar.deletePassword).toHaveBeenCalledWith('test-service', 'test-account');
    });
  });

  describe('hasCredentials', () => {
    it('returns true when credentials exist', async () => {
      (keytar.getPassword as any).mockResolvedValueOnce('{"deviceId":"id-1","deviceName":"Test","deviceType":"desktop","authToken":"synk_token"}');

      const result = await storage.hasCredentials();

      expect(result).toBe(true);
    });

    it('returns false when no credentials', async () => {
      (keytar.getPassword as any).mockResolvedValueOnce(null);

      const result = await storage.hasCredentials();

      expect(result).toBe(false);
    });
  });
});