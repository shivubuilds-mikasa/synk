/** Tests for configuration module. */

import { describe, it, expect, beforeEach, afterAll, vi } from 'vitest';
import { getConfig, getDefaultDeviceName } from './index';

describe('config', () => {
  const originalEnv = { ...process.env };

  beforeEach(() => {
    process.env = { ...originalEnv };
  });

  afterAll(() => {
    process.env = originalEnv;
  });

  describe('getConfig', () => {
    it('returns development defaults when no env vars set', () => {
      delete process.env.SYNK_BACKEND_URL;
      delete process.env.SYNK_DEVICE_NAME;
      delete process.env.SYNK_REQUEST_TIMEOUT_MS;

      const config = getConfig();

      expect(config.backendUrl).toBe('http://127.0.0.1:8000');
      expect(config.requestTimeoutMs).toBe(10000);
      expect(config.storageServiceName).toBe('synk-desktop');
      expect(config.storageAccountName).toBe('synk-credentials');
      expect(config.deviceName).toBeDefined();
      expect(config.deviceName.length).toBeGreaterThan(0);
    });

    it('uses SYNK_BACKEND_URL from environment', () => {
      process.env.SYNK_BACKEND_URL = 'http://custom-backend:9000';

      const config = getConfig();

      expect(config.backendUrl).toBe('http://custom-backend:9000');
    });

    it('uses SYNK_DEVICE_NAME from environment', () => {
      process.env.SYNK_DEVICE_NAME = 'Custom Device Name';

      const config = getConfig();

      expect(config.deviceName).toBe('Custom Device Name');
    });

    it('uses SYNK_REQUEST_TIMEOUT_MS from environment', () => {
      process.env.SYNK_REQUEST_TIMEOUT_MS = '5000';

      const config = getConfig();

      expect(config.requestTimeoutMs).toBe(5000);
    });

    it('strips trailing slash from backend URL', () => {
      process.env.SYNK_BACKEND_URL = 'http://backend:8000/';

      const config = getConfig();

      expect(config.backendUrl).toBe('http://backend:8000');
    });
  });

  describe('getDefaultDeviceName', () => {
    it('returns a non-empty string', () => {
      const name = getDefaultDeviceName();
      expect(name).toBeDefined();
      expect(name.length).toBeGreaterThan(0);
      expect(name).toContain('Synk Desktop');
    });
  });
});