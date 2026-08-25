// ignore_for_file: dangling_library_doc_comments, unnecessary_library_name

/// Clipboard synchronization screen for Synk mobile.
///
/// Displays connection status, sync status, and latest synchronized clipboard item.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:synk_mobile/services/clipboard/clipboard_service.dart';
import 'package:synk_mobile/services/sync/clipboard_sync_service.dart';
import 'package:synk_mobile/services/device_service.dart';

/// Screen showing clipboard synchronization status and controls.
class ClipboardSyncScreen extends StatefulWidget {
  const ClipboardSyncScreen({super.key});

  @override
  State<ClipboardSyncScreen> createState() => _ClipboardSyncScreenState();
}

class _ClipboardSyncScreenState extends State<ClipboardSyncScreen> {
  ClipboardSyncService? _syncService;
  String? _latestClipboardText;
  String? _lastSyncedSource;
  String? _lastError;
  StreamSubscription<ClipboardSyncState>? _stateSub;
  StreamSubscription<String>? _receivedSub;
  StreamSubscription<Object>? _errorSub;

  @override
  void initState() {
    super.initState();
    _initializeSync();
  }

  Future<void> _initializeSync() async {
    try {
      final deviceService = context.read<DeviceService>();
      final clipboardService = ClipboardService();

      _syncService = ClipboardSyncService(
        deviceService: deviceService,
        clipboardService: clipboardService,
      );

      _stateSub = _syncService!.stateStream.listen(_onStateChange);
      _receivedSub = _syncService!.receivedStream.listen(_onClipboardReceived);
      _errorSub = _syncService!.errorStream.listen(_onError);

      await _syncService!.initialize();

      // Read initial clipboard
      _latestClipboardText = await clipboardService.read();

      if (mounted) setState(() {});
    } catch (e) {
      if (mounted) {
        setState(() {
          _lastError = e.toString();
        });
      }
    }
  }

  void _onStateChange(ClipboardSyncState state) {
    if (mounted) setState(() {});
  }

  void _onClipboardReceived(String text) {
    if (mounted) {
      setState(() {
        _latestClipboardText = text;
        _lastSyncedSource = 'Synced from paired device';
      });
    }
  }

  void _onError(Object error) {
    if (mounted) {
      setState(() {
        _lastError = error.toString();
      });
    }
  }

  Future<void> _requestHistorySync() async {
    await _syncService?.requestHistorySync();
  }

  Future<void> _copyToClipboard() async {
    if (_latestClipboardText != null && _latestClipboardText!.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: _latestClipboardText!));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Copied to clipboard')),
        );
      }
    }
  }

  @override
  void dispose() {
    _stateSub?.cancel();
    _receivedSub?.cancel();
    _errorSub?.cancel();
    _syncService?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final syncState = _syncService?.syncState ?? ClipboardSyncState.disconnected;
    final isConnected = _syncService?.isSyncing ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clipboard Sync'),
        centerTitle: true,
        actions: [
          if (isConnected)
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: _requestHistorySync,
              tooltip: 'Request History Sync',
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Connection Status Card
              _ConnectionStatusCard(
                state: syncState,
                isConnected: isConnected,
                lastError: _lastError,
              ),
              const SizedBox(height: 16),

              // Paired Devices Status
              _PairedDevicesCard(),
              const SizedBox(height: 16),

              // Latest Clipboard Item
              Expanded(
                child: _LatestClipboardCard(
                  text: _latestClipboardText,
                  source: _lastSyncedSource,
                  onCopy: _copyToClipboard,
                  isConnected: isConnected,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Card showing WebSocket connection status.
class _ConnectionStatusCard extends StatelessWidget {
  final ClipboardSyncState state;
  final bool isConnected;
  final String? lastError;

  const _ConnectionStatusCard({
    required this.state,
    required this.isConnected,
    this.lastError,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (state) {
      case ClipboardSyncState.connected:
        statusColor = Colors.green;
        statusIcon = Icons.wifi;
        statusText = 'Connected';
        break;
      case ClipboardSyncState.connecting:
        statusColor = Colors.orange;
        statusIcon = Icons.wifi_find;
        statusText = 'Connecting...';
        break;
      case ClipboardSyncState.reconnecting:
        statusColor = Colors.orange;
        statusIcon = Icons.wifi_tethering;
        statusText = 'Reconnecting...';
        break;
      case ClipboardSyncState.error:
        statusColor = Colors.red;
        statusIcon = Icons.wifi_off;
        statusText = 'Error';
        break;
      case ClipboardSyncState.disconnected:
        statusColor = Colors.grey;
        statusIcon = Icons.wifi_off;
        statusText = 'Disconnected';
        break;
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  statusIcon,
                  color: statusColor,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Synk Connection',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              statusText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            if (lastError != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 16,
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        lastError!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Card showing paired devices status.
class _PairedDevicesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.devices,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Paired Devices',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Device pairing UI coming soon',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  'Use the backend API to pair devices',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Card showing the latest clipboard item.
class _LatestClipboardCard extends StatelessWidget {
  final String? text;
  final String? source;
  final VoidCallback onCopy;
  final bool isConnected;

  const _LatestClipboardCard({
    required this.text,
    this.source,
    required this.onCopy,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    final hasContent = text != null && text!.isNotEmpty;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.content_paste,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Latest Clipboard',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                if (hasContent && isConnected)
                  FilledButton.icon(
                    onPressed: onCopy,
                    icon: const Icon(Icons.copy, size: 18),
                    label: const Text('Copy'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (hasContent) ...[
              if (source != null) ...[
                Text(
                  source!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 8),
              ],
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                child: SelectableText(
                  text!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontFamily: 'monospace',
                      ),
                ),
              ),
            ] else ...[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.content_copy,
                      size: 48,
                      color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'No clipboard content synced yet',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Copy text on this device or a paired device to see it here',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}