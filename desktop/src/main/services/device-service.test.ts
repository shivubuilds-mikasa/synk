/** Tests for device service (authentication state logic). */

import { describe, it, expect, beforeEach, vi } from 'vitest';
import { DeviceService, AuthState } from './device-service';
import { apiClient, ApiError } from '../api/client';
import { secureStorage } from './secure-storage';
import { DeviceCredentials, DeviceType, DeviceRegistrationResponse } from '../models/device';

// Mock dependencies
vi.mock('../api/client', () => ({
  apiClient: {
    registerDevice: vi.fn(),
  },
  ApiError: class ApiError extends Error {
    constructor(message: string, public statusCode: number | null = null, public isNetworkError: boolean = false) {
      super(message);
    }
    static networkError(e: Error) { return new ApiError(e.message, null, true); }
    static timeoutError() { return new ApiError('Request timeout', null, true); }
    static httpError(code: number, msg: string) { return new ApiError(msg, code); }
  },
}));

vi.mock('./secure-storage', () => ({
  secureStorage: {
    getCredentials: vi.fn(),
    storeCredentials: vi.fn(),
    deleteCredentials: vi.fn(),
    hasCredentials: vi.fn(),
  },
}));

vi.mock('../config', () => ({
  config: {
    backendUrl: 'http://test:8000',
    deviceName: 'Test Device',
    requestTimeoutMs: 5000,
    storageServiceName: 'test',
    storageAccountName: 'test',
  },
}));

describe('DeviceService', () => {
  let service: DeviceService;

  beforeEach(() => {
    vi.clearAllMocks();
    service = new DeviceService();
  });

  describe('initialize', () => {
    it('loads existing credentials and sets authenticated state', async () => {
      const credentials: DeviceCredentials = {
        deviceId: 'id-1',
        deviceName: 'Test Device',
        deviceType: DeviceType.DESKTOP,
        authToken: 'synk_token',
      };

      (secureStorage.getCredentials as any).mockResolvedValueOnce(credentials);

      await service.initialize();

      const state = service.getState();
      expect(state.authState).toBe(AuthState.AUTHENTICATED);
      expect(state.deviceInfo).toEqual({
        deviceId: 'id-1',
        deviceName: 'Test Device',
        deviceType: DeviceType.DESKTOP,
      });
      expect(state.error).toBeNull();
    });

    it('registers new device when no credentials exist', async () => {
      (secureStorage.getCredentials as any).mockResolvedValueOnce(null);

      const mockResponse: DeviceRegistrationResponse = {
        device_id: 'new-id',
        device_name: 'Test Device',
        device_type: DeviceType.DESKTOP,
        auth_token: 'synk_newtoken',
      };

      (apiClient.registerDevice as any).mockResolvedValueOnce({ ok: true, data: mockResponse });
      (secureStorage.storeCredentials as any).mockResolvedValueOnce(undefined);

      await service.initialize();

      const state = service.getState();
      expect(state.authState).toBe(AuthState.AUTHENTICATED);
      expect(state.deviceInfo?.deviceId).toBe('new-id');
      expect(apiClient.registerDevice).toHaveBeenCalledWith('Test Device', DeviceType.DESKTOP);
    });

    it('handles registration failure', async () => {
      (secureStorage.getCredentials as any).mockResolvedValueOnce(null);
      (apiClient.registerDevice as any).mockResolvedValueOnce({
        ok: false,
        error: { message: 'Backend unavailable', statusCode: 503, isNetworkError: false, originalError: null },
      });

      await service.initialize();

      const state = service.getState();
      expect(state.authState).toBe(AuthState.ERROR);
      expect(state.error).toContain('Registration failed');
    });

    it('handles storage failure after successful registration', async () => {
      (secureStorage.getCredentials as any).mockResolvedValueOnce(null);

      const mockResponse: DeviceRegistrationResponse = {
        device_id: 'new-id',
        device_name: 'Test Device',
        device_type: DeviceType.DESKTOP,
        auth_token: 'synk_newtoken',
      };

      (apiClient.registerDevice as any).mockResolvedValueOnce({ ok: true, data: mockResponse });
      (secureStorage.storeCredentials as any).mockRejectedValueOnce(new Error('Keychain locked'));

      await service.initialize();

      const state = service.getState();
      expect(state.authState).toBe(AuthState.ERROR);
      expect(state.error).toContain('Failed to store credentials');
    });

    it('handles load credentials failure', async () => {
      (secureStorage.getCredentials as any).mockRejectedValueOnce(new Error('Storage corrupted'));

      await service.initialize();

      const state = service.getState();
      expect(state.authState).toBe(AuthState.ERROR);
      expect(state.error).toContain('Failed to load credentials');
    });
  });

  describe('state subscriptions', () => {
    it('notifies subscribers on state change', async () => {
      const listener = vi.fn();
      const unsubscribe = service.subscribe(listener);

      (secureStorage.getCredentials as any).mockResolvedValueOnce(null);
      const mockResponse: DeviceRegistrationResponse = {
        device_id: 'id-1',
        device_name: 'Test',
        device_type: DeviceType.DESKTOP,
        auth_token: 'synk_token',
      };
      (apiClient.registerDevice as any).mockResolvedValueOnce({ ok: true, data: mockResponse });
      (secureStorage.storeCredentials as any).mockResolvedValueOnce(undefined);

      await service.initialize();

      expect(listener).toHaveBeenCalled();
      // Check the last call (final state) since listener is called for REGISTERING then AUTHENTICATED
      const calledState = listener.mock.calls[listener.mock.calls.length - 1][0];
      expect(calledState.authState).toBe(AuthState.AUTHENTICATED);

      unsubscribe();
    });
  });

  describe('getAuthToken', () => {
    it('returns auth token from credentials', async () => {
      const credentials: DeviceCredentials = {
        deviceId: 'id-1',
        deviceName: 'Test',
        deviceType: DeviceType.DESKTOP,
        authToken: 'synk_secret',
      };
      (secureStorage.getCredentials as any).mockResolvedValueOnce(credentials);

      const token = await service.getAuthToken();

      expect(token).toBe('synk_secret');
    });

    it('returns null when no credentials', async () => {
      (secureStorage.getCredentials as any).mockResolvedValueOnce(null);

      const token = await service.getAuthToken();

      expect(token).toBeNull();
    });
  });

  describe('clearCredentials', () => {
    it('deletes storage and resets state', async () => {
      (secureStorage.deleteCredentials as any).mockResolvedValueOnce(undefined);

      await service.clearCredentials();

      const state = service.getState();
      expect(state.authState).toBe(AuthState.UNINITIALIZED);
      expect(state.deviceInfo).toBeNull();
      expect(state.error).toBeNull();
    });
  });
});