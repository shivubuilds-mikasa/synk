/**
 * Typed API client for Synk backend communication.
 *
 * Handles device registration and authenticated requests.
 * Uses proper timeout handling and clear error types.
 */

import { config } from '../config';
import {
  DeviceRegistrationRequest,
  DeviceRegistrationResponse,
  DeviceResponse,
  DeviceType,
} from '../models/device';

/** Re-export types for consumers. */
export { DeviceType, DeviceRegistrationResponse };

/** Base API error class for type-safe error handling. */
export class ApiError extends Error {
  constructor(
    message: string,
    public readonly statusCode: number | null,
    public readonly isNetworkError: boolean = false,
    public readonly originalError: Error | null = null,
  ) {
    super(message);
    this.name = 'ApiError';
  }

  static networkError(originalError: Error): ApiError {
    return new ApiError(
      `Network error: ${originalError.message}`,
      null,
      true,
      originalError,
    );
  }

  static timeoutError(): ApiError {
    return new ApiError('Request timeout', null, true);
  }

  static httpError(statusCode: number, message: string): ApiError {
    return new ApiError(message, statusCode, false);
  }
}

/** Result type for API calls. */
export type ApiResult<T> = { ok: true; data: T } | { ok: false; error: ApiError };

/** HTTP client with timeout and error handling. */
class HttpClient {
  private baseUrl: string;
  private timeoutMs: number;

  constructor(baseUrl: string, timeoutMs: number) {
    this.baseUrl = baseUrl.replace(/\/$/, ''); // Remove trailing slash
    this.timeoutMs = timeoutMs;
  }

  private async request<T>(
    method: string,
    path: string,
    options: {
      body?: unknown;
      headers?: Record<string, string>;
      authToken?: string;
    } = {},
  ): Promise<ApiResult<T>> {
    const url = `${this.baseUrl}${path}`;
    const headers: Record<string, string> = {
      'Content-Type': 'application/json',
      Accept: 'application/json',
      ...options.headers,
    };

    if (options.authToken) {
      headers.Authorization = `Bearer ${options.authToken}`;
    }

    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), this.timeoutMs);

    try {
      const response = await fetch(url, {
        method,
        headers,
        body: options.body ? JSON.stringify(options.body) : undefined,
        signal: controller.signal,
      });

      clearTimeout(timeoutId);

      if (!response.ok) {
        let errorMessage = `HTTP ${response.status}`;
        try {
          const errorData: unknown = await response.json();
          if (typeof errorData === 'object' && errorData !== null && 'detail' in errorData) {
            const detail = (errorData as Record<string, unknown>).detail;
            errorMessage = typeof detail === 'string' ? detail : errorMessage;
          }
        } catch {
          // Ignore JSON parse errors, use status text
          errorMessage = response.statusText || errorMessage;
        }
        return { ok: false, error: ApiError.httpError(response.status, errorMessage) };
      }

      if (response.status === 204) {
        return { ok: true, data: undefined as T };
      }

      const data = await response.json() as T;
      return { ok: true, data };
    } catch (err) {
      clearTimeout(timeoutId);
      if (err instanceof DOMException && err.name === 'AbortError') {
        return { ok: false, error: ApiError.timeoutError() };
      }
      return { ok: false, error: ApiError.networkError(err instanceof Error ? err : new Error(String(err))) };
    }
  }

  async get<T>(path: string, authToken?: string): Promise<ApiResult<T>> {
    return this.request<T>('GET', path, { authToken });
  }

  async post<T>(path: string, body: unknown, authToken?: string): Promise<ApiResult<T>> {
    return this.request<T>('POST', path, { body, authToken });
  }
}

/** Synk API client for device registration and authentication. */
export class SynkApiClient {
  private client: HttpClient;

  constructor(baseUrl?: string, timeoutMs?: number) {
    const cfg = config;
    this.client = new HttpClient(baseUrl ?? cfg.backendUrl, timeoutMs ?? cfg.requestTimeoutMs);
  }

  /**
   * Register a new device.
   * Returns device credentials including the auth_token (only returned once).
   */
  async registerDevice(
    deviceName: string,
    deviceType: DeviceType = DeviceType.DESKTOP,
  ): Promise<ApiResult<DeviceRegistrationResponse>> {
    const request: DeviceRegistrationRequest = {
      device_name: deviceName,
      device_type: deviceType,
    };

    return this.client.post<DeviceRegistrationResponse>('/api/v1/devices/register', request);
  }

  /**
   * Get device info by ID (requires authentication).
   */
  async getDevice(deviceId: string, authToken: string): Promise<ApiResult<DeviceResponse>> {
    return this.client.get<DeviceResponse>(`/api/v1/devices/${deviceId}`, authToken);
  }

  /**
   * Test connectivity to the backend.
   */
  async healthCheck(): Promise<ApiResult<{ status: string }>> {
    return this.client.get<{ status: string }>('/health');
  }
}

/** Default client instance using config. */
export const apiClient = new SynkApiClient();