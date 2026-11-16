import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synk_mobile/core/network/api_client.dart';
import 'package:synk_mobile/models/pairing.dart';
import 'package:synk_mobile/services/device_service.dart';
import 'package:synk_mobile/services/pairing_service.dart';

/// Lets a device create a pairing code, join another device, and view pairings.
class PairingScreen extends StatefulWidget {
  const PairingScreen({super.key});

  @override
  State<PairingScreen> createState() => _PairingScreenState();
}

class _PairingScreenState extends State<PairingScreen> {
  final _codeController = TextEditingController();
  PairingService? _pairingService;
  String? _deviceId;
  PairingCreateResponse? _createdCode;
  List<PairedDeviceInfo> _devices = const [];
  bool _loading = true;
  bool _working = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final deviceService = context.read<DeviceService>();
      _pairingService = PairingService(apiClient: context.read<ApiClient>());
      _deviceId = await deviceService.getStoredDeviceId();
      if (_deviceId == null) throw StateError('This device is not registered.');
      await _refreshDevices();
    } catch (error) {
      _error = error.toString();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _refreshDevices() async {
    final response = await _pairingService!.getPairedDevices(_deviceId!);
    _devices = response.pairedDevices;
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _working = true;
      _error = null;
    });
    try {
      await action();
    } catch (error) {
      _error = error.toString();
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _createCode() => _run(() async {
    _createdCode = await _pairingService!.createCode();
  });

  Future<void> _confirmCode() => _run(() async {
    final code = _codeController.text.trim();
    if (!RegExp(r'^\d{6}$').hasMatch(code)) {
      throw const FormatException(
        'Enter the six-digit code from the other device.',
      );
    }
    await _pairingService!.confirmCode(code);
    _codeController.clear();
    await _refreshDevices();
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paired devices')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Pair a new device',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Create a code here, then enter it on the other device.',
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: _working ? null : _createCode,
                          icon: const Icon(Icons.qr_code_2),
                          label: const Text('Create pairing code'),
                        ),
                        if (_createdCode != null) ...[
                          const SizedBox(height: 12),
                          SelectableText(
                            _createdCode!.code,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(
                                  letterSpacing: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            'Expires ${_createdCode!.expiresAt}',
                            textAlign: TextAlign.center,
                          ),
                        ],
                        const SizedBox(height: 24),
                        TextField(
                          controller: _codeController,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          decoration: const InputDecoration(
                            labelText: 'Code from another device',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        FilledButton.tonal(
                          onPressed: _working ? null : _confirmCode,
                          child: const Text('Pair with code'),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Connected devices',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Refresh devices',
                      onPressed: _working ? null : () => _run(_refreshDevices),
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
                if (_devices.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('No devices paired yet.'),
                  )
                else
                  ..._devices.map(
                    (device) => ListTile(
                      leading: const Icon(Icons.devices),
                      title: Text(device.deviceName),
                      subtitle: Text(
                        '${device.deviceType} · ${device.deviceId}',
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
