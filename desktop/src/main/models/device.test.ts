/** Tests for device model/types. */

import { describe, it, expect } from 'vitest';
import {
  DeviceType,
  DeviceCredentials,
  DeviceInfo,
  DeviceRegistrationRequest,
  DeviceRegistrationResponse,
  DeviceResponse,
  toDeviceCredentials,
  toDeviceInfo,
} from './device';

describe('Device model/types', () => {
  describe('DeviceType enum', () => {
    it('has correct values', () => {
      expect(DeviceType.MOBILE).toBe('mobile');
      expect(DeviceType.DESKTOP).toBe('desktop');
    });
  });

  describe('toDeviceCredentials', () => {
    it('converts registration response to credentials', () => {
      const response: DeviceRegistrationResponse = {
        device_id: '550e8400-e29b-41d4-a716-446655440000',
        device_name: 'Test Desktop',
        device_type: DeviceType.DESKTOP,
        auth_token: 'synk_abcdef1234567890abcdef1234567890abcdef1234567890abcdef123456',
      };

      const credentials = toDeviceCredentials(response);

      expect(credentials.deviceId).toBe(response.device_id);
      expect(credentials.deviceName).toBe(response.device_name);
      expect(credentials.deviceType).toBe(response.device_type);
      expect(credentials.authToken).toBe(response.auth_token);
    });
  });

  describe('toDeviceInfo', () => {
    it('converts credentials to info (no token)', () => {
      const credentials: DeviceCredentials = {
        deviceId: '550e8400-e29b-41d4-a716-446655440000',
        deviceName: 'Test Desktop',
        deviceType: DeviceType.DESKTOP,
        authToken: 'synk_abcdef1234567890abcdef1234567890abcdef1234567890abcdef123456',
      };

      const info = toDeviceInfo(credentials);

      expect(info.deviceId).toBe(credentials.deviceId);
      expect(info.deviceName).toBe(credentials.deviceName);
      expect(info.deviceType).toBe(credentials.deviceType);
      // Ensure no authToken in DeviceInfo
      expect('authToken' in info).toBe(false);
    });
  });

  describe('Type interfaces', () => {
    it('DeviceRegistrationRequest accepts valid data', () => {
      const request: DeviceRegistrationRequest = {
        device_name: 'Test Device',
        device_type: DeviceType.MOBILE,
      };
      expect(request.device_name).toBe('Test Device');
      expect(request.device_type).toBe(DeviceType.MOBILE);
    });

    it('DeviceRegistrationResponse includes auth_token', () => {
      const response: DeviceRegistrationResponse = {
        device_id: 'id-1',
        device_name: 'Test',
        device_type: DeviceType.DESKTOP,
        auth_token: 'synk_token',
      };
      expect(response.auth_token).toBeDefined();
    });

    it('DeviceResponse has required fields', () => {
      const response: DeviceResponse = {
        device_id: 'id-1',
        device_name: 'Test',
        device_type: DeviceType.DESKTOP,
      };
      expect(response.device_id).toBe('id-1');
      expect(response.device_name).toBe('Test');
      expect(response.device_type).toBe(DeviceType.DESKTOP);
    });
  });
});