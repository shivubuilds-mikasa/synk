import { app, BrowserWindow, ipcMain } from 'electron';
import * as path from 'path';
import { deviceService, AuthState, DeviceState } from './services/device-service';
import { secureStorage } from './services/secure-storage';
import { config } from './config';
import { ClipboardSyncService, ClipboardSyncState } from './services/clipboard-sync-service';
import { ClipboardService } from './services/clipboard-service';

let mainWindow: BrowserWindow | null = null;
let clipboardSyncService: ClipboardSyncService | null = null;
let clipboardService: ClipboardService | null = null;

/**
 * Create the main application window.
 */
function createWindow(): void {
  mainWindow = new BrowserWindow({
    width: 1200,
    height: 800,
    webPreferences: {
      preload: path.join(__dirname, '../preload/preload.js'),
      contextIsolation: true,
      nodeIntegration: false,
      sandbox: true,
    },
  });

  // Always load local file since we don't use Vite dev server
  mainWindow.loadFile(path.join(__dirname, '../renderer/index.html'));
  mainWindow.webContents.openDevTools();

  mainWindow.on('closed', () => {
    mainWindow = null;
  });
}

/**
 * Send state update to renderer.
 */
function sendStateToRenderer(state: DeviceState): void {
  if (mainWindow && !mainWindow.isDestroyed()) {
    mainWindow.webContents.send('device-state-changed', state);
  }
}

/**
 * Send clipboard sync state update to renderer.
 */
function sendClipboardSyncStateToRenderer(state: ClipboardSyncState): void {
  if (mainWindow && !mainWindow.isDestroyed()) {
    mainWindow.webContents.send('clipboard-sync-state-changed', state);
  }
}

/**
 * Send received clipboard content to renderer.
 */
function sendClipboardReceivedToRenderer(text: string, sourceDeviceId: string): void {
  if (mainWindow && !mainWindow.isDestroyed()) {
    mainWindow.webContents.send('clipboard-received', { text, sourceDeviceId });
  }
}

/**
 * Send paired device online event to renderer.
 */
function sendPairedDeviceOnlineToRenderer(deviceId: string): void {
  if (mainWindow && !mainWindow.isDestroyed()) {
    mainWindow.webContents.send('paired-device-online', deviceId);
  }
}

/**
 * Send paired device offline event to renderer.
 */
function sendPairedDeviceOfflineToRenderer(deviceId: string): void {
  if (mainWindow && !mainWindow.isDestroyed()) {
    mainWindow.webContents.send('paired-device-offline', deviceId);
  }
}

/**
 * Initialize device service and set up state listener.
 */
async function initializeDeviceService(): Promise<void> {
  // Subscribe to state changes and forward to renderer
  const unsubscribe = deviceService.subscribe((state) => {
    sendStateToRenderer(state);
  });

  // Store unsubscribe for cleanup (though app quit handles it)
  // Initialize the service (checks credentials, registers if needed)
  await deviceService.initialize();

  // Initialize clipboard sync after device is authenticated
  if (deviceService.getState().authState === AuthState.AUTHENTICATED) {
    await initializeClipboardSync();
  }

  // Keep reference to prevent GC
  // In practice, app lifetime manages this
}

/**
 * Initialize clipboard synchronization service.
 */
async function initializeClipboardSync(): Promise<void> {
  const deviceInfo = deviceService.getDeviceInfo();
  const authToken = await deviceService.getAuthToken();

  if (!deviceInfo || !authToken) {
    console.warn('Cannot initialize clipboard sync: missing device info or auth token');
    return;
  }

  // Build WebSocket URL (no /api/v1 prefix for websocket endpoint)
  const wsUrl = config.backendUrl.replace('http://', 'ws://').replace('https://', 'wss://');
  const fullWsUrl = `${wsUrl}/ws/${deviceInfo.deviceId}`;

  // Create clipboard service and sync service
  clipboardService = new ClipboardService(1000); // 1 second polling
  clipboardSyncService = new ClipboardSyncService(
    deviceInfo.deviceId,
    authToken,
    fullWsUrl,
    clipboardService
  );

  // Subscribe to clipboard sync state changes
  clipboardSyncService.on('stateChange', (state) => {
    sendClipboardSyncStateToRenderer(state);
  });

  // Subscribe to received clipboard updates
  clipboardSyncService.on('clipboardReceived', (text, sourceDeviceId) => {
    sendClipboardReceivedToRenderer(text, sourceDeviceId);
  });

  // Subscribe to paired device online/offline
  clipboardSyncService.on('pairedDeviceOnline', (deviceId) => {
    sendPairedDeviceOnlineToRenderer(deviceId);
  });

  clipboardSyncService.on('pairedDeviceOffline', (deviceId) => {
    sendPairedDeviceOfflineToRenderer(deviceId);
  });

  // Subscribe to errors
  clipboardSyncService.on('error', (error) => {
    // Error already emitted to renderer via error event
  });

  // Initialize and connect
  try {
    await clipboardSyncService.initialize();
  } catch (error) {
    // Error already emitted to renderer via error event
  }
}

/**
 * IPC handlers for renderer communication.
 */
function setupIpcHandlers(): void {
  // Get current device state
  ipcMain.handle('device:get-state', () => deviceService.getState());

  // Force re-registration (for testing)
  ipcMain.handle('device:re-register', async () => {
    await secureStorage.deleteCredentials();
    return deviceService.initialize();
  });

  // Ping for testing
  ipcMain.handle('ping', () => 'pong');

  // Get clipboard sync state
  ipcMain.handle('clipboard-sync:get-state', () => clipboardSyncService?.state ?? ClipboardSyncState.Disconnected);

  // Request history sync
  ipcMain.handle('clipboard-sync:request-history', async (_, limit?: number) => {
    await clipboardSyncService?.requestHistorySync(limit ?? 50);
  });

  // Send clipboard update (for manual sync from UI)
  ipcMain.handle('clipboard-sync:send-update', async (_, text: string) => {
    // This would require a new method in ClipboardSyncService
    // For now, we rely on polling
    return false;
  });
}

app.whenReady().then(async () => {
  setupIpcHandlers();
  await initializeDeviceService();
  createWindow();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow();
    }
  });
});

app.on('window-all-closed', () => {
  // Cleanup clipboard sync
  clipboardSyncService?.dispose();
  clipboardService?.dispose();

  if (process.platform !== 'darwin') {
    app.quit();
  }
});
