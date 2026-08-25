/**
 * Device registration and authentication service.
 *
 * Coordinates:
 * - API client for backend communication
 * - Secure storage for credential persistence
 * - Device model for type safety
 */

import { apiClient, ApiError, ApiResult } from '../api/client';
import { secureStorage } from './secure-storage';
import { config } from '../config';
import {
  DeviceCredentials,
  DeviceInfo,
  DeviceRegistrationResponse,
  DeviceType,
  toDeviceCredentials,
  toDeviceInfo,
} from '../models/device';

export enum AuthState {
  UNINITIALIZED = 'uninitialized',
  REGISTERING = 'registering',
  AUTHENTICATED = 'authenticated',
  ERROR = 'error',
}

export interface DeviceState {
  authState: AuthState;
  deviceInfo: DeviceInfo | null;
  error: string | null;
}

/** Device service for managing registration and auth state. */
export class DeviceService {
  private state: DeviceState = {
    authState: AuthState.UNINITIALIZED,
    deviceInfo: null,
    error: null,
  };

  private stateListeners: Array<(state: DeviceState) => void> = [];

  /**
   * Get current authentication state.
   */
  getState(): DeviceState {
    return { ...this.state };
  }

  /**
   * Subscribe to state changes.
   */
  subscribe(listener: (state: DeviceState) => void): () => void {
    this.stateListeners.push(listener);
    return () => {
      const idx = this.stateListeners.indexOf(listener);
      if (idx >= 0) this.stateListeners.splice(idx, 1);
    };
  }

  private setState(partial: Partial<DeviceState>): void {
    this.state = { ...this.state, ...partial };
    this.notifyListeners();
  }

  private notifyListeners(): void {
    for (const listener of this.stateListeners) {
      listener(this.getState());
    }
  }

  /**
   * Initialize the device service.
   * Checks for existing credentials; if none, registers the device.
   */
  async initialize(): Promise<void> {
    // Check for existing credentials
    const existing = await this.loadCredentials();
    // If loadCredentials failed, it already set ERROR state - don't proceed to registration
    if (this.state.authState === AuthState.ERROR) {
      return;
    }
    if (existing) {
      this.setState({
        authState: AuthState.AUTHENTICATED,
        deviceInfo: toDeviceInfo(existing),
        error: null,
      });
      return;
    }

    // No credentials - register
    await this.registerDevice();
  }

  /**
   * Load credentials from secure storage.
   */
  async loadCredentials(): Promise<DeviceCredentials | null> {
    try {
      return await secureStorage.getCredentials();
    } catch (err) {
      const message = err instanceof Error ? err.message : 'Unknown storage error';
      this.setState({
        authState: AuthState.ERROR,
        error: `Failed to load credentials: ${message}`,
      });
      return null;
    }
  }

  /**
   * Register this device with the backend.
   */
  async registerDevice(): Promise<DeviceCredentials | null> {
    this.setState({
      authState: AuthState.REGISTERING,
      error: null,
    });

    try {
      const result = await apiClient.registerDevice(config.deviceName, DeviceType.DESKTOP);

      if (!result.ok) {
        this.setState({
          authState: AuthState.ERROR,
          error: `Registration failed: ${result.error.message}`,
        });
        return null;
      }

      const credentials = toDeviceCredentials(result.data);

      // Store securely
      try {
        await secureStorage.storeCredentials(credentials);
      } catch (err) {
        const message = err instanceof Error ? err.message : 'Unknown storage error';
        this.setState({
          authState: AuthState.ERROR,
          error: `Failed to store credentials: ${message}`,
        });
        return null;
      }

      this.setState({
        authState: AuthState.AUTHENTICATED,
        deviceInfo: toDeviceInfo(credentials),
        error: null,
      });

      return credentials;
    } catch (err) {
      const message = err instanceof Error ? err.message : 'Unknown error';
      this.setState({
        authState: AuthState.ERROR,
        error: `Registration error: ${message}`,
      });
      return null;
    }
  }

  /**
   * Get stored auth token for authenticated requests.
   */
  async getAuthToken(): Promise<string | null> {
    const credentials = await this.loadCredentials();
    return credentials?.authToken ?? null;
  }

  /**
   * Get device info (for UI).
   */
  getDeviceInfo(): DeviceInfo | null {
    return this.state.deviceInfo;
  }

  /**
   * Clear credentials and reset state (for testing/logout).
   */
  async clearCredentials(): Promise<void> {
    try {
      await secureStorage.deleteCredentials();
    } catch {
      // Ignore errors on delete
    }
    this.setState({
      authState: AuthState.UNINITIALIZED,
      deviceInfo: null,
      error: null,
    });
  }
}

/** Default device service instance. */
export const deviceService = new DeviceService();