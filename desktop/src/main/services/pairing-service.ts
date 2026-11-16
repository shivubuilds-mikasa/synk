import { apiClient } from '../api/client';
import { deviceService } from './device-service';

export interface PairingCode {
  code: string;
  expires_at: string;
  device_id: string;
}

export interface PairedDevice {
  device_id: string;
  device_name: string;
  device_type: 'mobile' | 'desktop';
}

export interface PairedDevicesResponse {
  device_id: string;
  paired_devices: PairedDevice[];
}

export class PairingService {
  private async getCredentials(): Promise<{ deviceId: string; authToken: string }> {
    const deviceInfo = deviceService.getDeviceInfo();
    const authToken = await deviceService.getAuthToken();
    if (!deviceInfo || !authToken) {
      throw new Error('Register this device before managing pairings.');
    }
    return { deviceId: deviceInfo.deviceId, authToken };
  }

  async createCode(): Promise<PairingCode> {
    const { authToken } = await this.getCredentials();
    const result = await apiClient.post<PairingCode>(
      '/api/v1/pairing/create',
      {},
      authToken,
    );
    if (!result.ok) throw result.error;
    return result.data;
  }

  async confirmCode(code: string): Promise<{ paired_device: PairedDevice }> {
    const { authToken } = await this.getCredentials();
    const result = await apiClient.post<{ paired_device: PairedDevice }>(
      '/api/v1/pairing/confirm',
      { code },
      authToken,
    );
    if (!result.ok) throw result.error;
    return result.data;
  }

  async getPairedDevices(): Promise<PairedDevicesResponse> {
    const { deviceId, authToken } = await this.getCredentials();
    const result = await apiClient.get<PairedDevicesResponse>(
      `/api/v1/pairing/${deviceId}`,
      authToken,
    );
    if (!result.ok) throw result.error;
    return result.data;
  }
}

export const pairingService = new PairingService();
