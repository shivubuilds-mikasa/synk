/** Tests for API client. */

import { describe, it, expect, beforeEach, vi } from 'vitest';
import { SynkApiClient, ApiError, DeviceType, DeviceRegistrationResponse } from './client';

// Mock fetch globally
const mockFetch = vi.fn();
global.fetch = mockFetch;

describe('SynkApiClient', () => {
  let client: SynkApiClient;

  beforeEach(() => {
    vi.clearAllMocks();
    client = new SynkApiClient('http://test-backend:8000', 5000);
  });

  describe('registerDevice', () => {
    it('sends correct request and parses response', async () => {
      const mockResponse: DeviceRegistrationResponse = {
        device_id: '550e8400-e29b-41d4-a716-446655440000',
        device_name: 'Test Desktop',
        device_type: DeviceType.DESKTOP,
        auth_token: 'synk_abcdef1234567890abcdef1234567890abcdef1234567890abcdef123456',
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        status: 201,
        json: async () => mockResponse,
      });

      const result = await client.registerDevice('Test Desktop', DeviceType.DESKTOP);

      expect(result.ok).toBe(true);
      if (result.ok) {
        expect(result.data).toEqual(mockResponse);
      }

      expect(mockFetch).toHaveBeenCalledWith(
        'http://test-backend:8000/api/v1/devices/register',
        expect.objectContaining({
          method: 'POST',
          headers: expect.objectContaining({
            'Content-Type': 'application/json',
            Accept: 'application/json',
          }),
          body: JSON.stringify({
            device_name: 'Test Desktop',
            device_type: 'desktop',
          }),
        }),
      );
    });

    it('handles registration failure with 422', async () => {
      mockFetch.mockResolvedValueOnce({
        ok: false,
        status: 422,
        json: async () => ({ detail: 'Invalid device_type' }),
      });

      const result = await client.registerDevice('Test', 'invalid' as DeviceType);

      expect(result.ok).toBe(false);
      if (!result.ok) {
        expect(result.error.statusCode).toBe(422);
        expect(result.error.message).toContain('Invalid device_type');
      }
    });

    it('handles network error', async () => {
      mockFetch.mockRejectedValueOnce(new Error('fetch failed'));

      const result = await client.registerDevice('Test');

      expect(result.ok).toBe(false);
      if (!result.ok) {
        expect(result.error.isNetworkError).toBe(true);
        expect(result.error.message).toContain('Network error');
      }
    });

    it('handles timeout', async () => {
      const abortError = new DOMException('Aborted', 'AbortError');
      mockFetch.mockRejectedValueOnce(abortError);

      const result = await client.registerDevice('Test');

      expect(result.ok).toBe(false);
      if (!result.ok) {
        expect(result.error.message).toBe('Request timeout');
      }
    });
  });

  describe('getDevice', () => {
    it('includes auth token in Authorization header', async () => {
      const mockResponse = {
        device_id: '550e8400-e29b-41d4-a716-446655440000',
        device_name: 'Test Desktop',
        device_type: DeviceType.DESKTOP,
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        status: 200,
        json: async () => mockResponse,
      });

      const result = await client.getDevice('550e8400-e29b-41d4-a716-446655440000', 'synk_testtoken');

      expect(result.ok).toBe(true);
      expect(mockFetch).toHaveBeenCalledWith(
        'http://test-backend:8000/api/v1/devices/550e8400-e29b-41d4-a716-446655440000',
        expect.objectContaining({
          method: 'GET',
          headers: expect.objectContaining({
            Authorization: 'Bearer synk_testtoken',
          }),
        }),
      );
    });
  });

  describe('healthCheck', () => {
    it('makes GET request to /health', async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        status: 200,
        json: async () => ({ status: 'ok' }),
      });

      const result = await client.healthCheck();

      expect(result.ok).toBe(true);
      expect(mockFetch).toHaveBeenCalledWith(
        'http://test-backend:8000/health',
        expect.objectContaining({ method: 'GET' }),
      );
    });
  });
});