/**
 * Synk Device model and related types.
 *
 * Mirrors the backend DeviceRegistrationResponse and DeviceResponse models.
 */

export enum DeviceType {
  MOBILE = 'mobile',
  DESKTOP = 'desktop',
}

/**
 * Device credentials stored securely.
 * Contains the auth_token which is only returned once during registration.
 */
export interface DeviceCredentials {
  deviceId: string;
  deviceName: string;
  deviceType: DeviceType;
  authToken: string;
}

/**
 * Device info for UI display (no auth token).
 */
export interface DeviceInfo {
  deviceId: string;
  deviceName: string;
  deviceType: DeviceType;
}

/**
 * Registration request payload.
 */
export interface DeviceRegistrationRequest {
  device_name: string;
  device_type: DeviceType;
}

/**
 * Registration response from backend.
 */
export interface DeviceRegistrationResponse {
  device_id: string;
  device_name: string;
  device_type: DeviceType;
  auth_token: string;
}

/**
 * Device retrieval response (no auth_token).
 */
export interface DeviceResponse {
  device_id: string;
  device_name: string;
  device_type: DeviceType;
}

/**
 * Convert backend registration response to internal credentials.
 */
export function toDeviceCredentials(response: DeviceRegistrationResponse): DeviceCredentials {
  return {
    deviceId: response.device_id,
    deviceName: response.device_name,
    deviceType: response.device_type,
    authToken: response.auth_token,
  };
}

/**
 * Convert credentials to device info (for UI, no token).
 */
export function toDeviceInfo(credentials: DeviceCredentials): DeviceInfo {
  return {
    deviceId: credentials.deviceId,
    deviceName: credentials.deviceName,
    deviceType: credentials.deviceType,
  };
}