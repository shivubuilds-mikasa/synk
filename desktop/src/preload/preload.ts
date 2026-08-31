import { contextBridge, ipcRenderer } from 'electron';

/** Device info for renderer (no auth token). */
interface DeviceInfo {
  
  deviceId: string;
  deviceName: string;
  deviceType: 'mobile' | 'desktop';
}

/** Device state sent from main process. */
interface DeviceState {
  authState: 'uninitialized' | 'registering' | 'authenticated' | 'error';
  deviceInfo: DeviceInfo | null;
  error: string | null;
}

/** Clipboard sync state. */
type ClipboardSyncState = 'disconnected' | 'connecting' | 'connected' | 'reconnecting' | 'error';

/** Type-safe API exposed to renderer. */
contextBridge.exposeInMainWorld('api', {
  /** Get current device state. */
  getDeviceState: (): Promise<DeviceState> => ipcRenderer.invoke('device:get-state'),

  /** Force re-registration (testing only). */
  reRegister: (): Promise<void> => ipcRenderer.invoke('device:re-register'),

  /** Subscribe to state changes from main process. */
  onDeviceStateChange: (callback: (state: DeviceState) => void) => {
    const handler = (_event: Electron.IpcRendererEvent, state: DeviceState) => {
      callback(state);
    };
    ipcRenderer.on('device-state-changed', handler);
    return () => ipcRenderer.off('device-state-changed', handler);
  },

  /** Ping for testing. */
  ping: () => ipcRenderer.invoke('ping'),

  /** Get current clipboard sync state. */
  getClipboardSyncState: (): Promise<ClipboardSyncState> =>
    ipcRenderer.invoke('clipboard-sync:get-state'),

  /** Request history sync from server. */
  requestHistorySync: (limit?: number): Promise<void> =>
    ipcRenderer.invoke('clipboard-sync:request-history', limit),

  /** Subscribe to clipboard sync state changes. */
  onClipboardSyncStateChange: (callback: (state: ClipboardSyncState) => void) => {
    const handler = (_event: Electron.IpcRendererEvent, state: ClipboardSyncState) => {
      callback(state);
    };
    ipcRenderer.on('clipboard-sync-state-changed', handler);
    return () => ipcRenderer.off('clipboard-sync-state-changed', handler);
  },

  /** Subscribe to received clipboard updates from paired devices. */
  onClipboardReceived: (callback: (text: string, sourceDeviceId: string) => void) => {
    const handler = (
      _event: Electron.IpcRendererEvent,
      data: { text: string; sourceDeviceId: string }
    ) => {
      callback(data.text, data.sourceDeviceId);
    };
    ipcRenderer.on('clipboard-received', handler);
    return () => ipcRenderer.off('clipboard-received', handler);
  },

  /** Subscribe to paired device online events. */
  onPairedDeviceOnline: (callback: (deviceId: string) => void) => {
    const handler = (_event: Electron.IpcRendererEvent, deviceId: string) => {
      callback(deviceId);
    };
    ipcRenderer.on('paired-device-online', handler);
    return () => ipcRenderer.off('paired-device-online', handler);
  },

  /** Subscribe to paired device offline events. */
  onPairedDeviceOffline: (callback: (deviceId: string) => void) => {
    const handler = (_event: Electron.IpcRendererEvent, deviceId: string) => {
      callback(deviceId);
    };
    ipcRenderer.on('paired-device-offline', handler);
    return () => ipcRenderer.off('paired-device-offline', handler);
  },
});
