// Pairing API operations for the authenticated device.
import 'package:synk_mobile/core/network/api_client.dart';
import 'package:synk_mobile/models/pairing.dart';

class PairingService {
  final ApiClient apiClient;

  PairingService({required this.apiClient});

  Future<PairingCreateResponse> createCode() =>
      apiClient.post<PairingCreateResponse>(
        '/pairing/create',
        parser: (json) =>
            PairingCreateResponse.fromJson(json as Map<String, dynamic>),
      );

  Future<PairingConfirmResponse> confirmCode(String code) =>
      apiClient.post<PairingConfirmResponse>(
        '/pairing/confirm',
        body: PairingConfirmRequest(code: code).toJson(),
        parser: (json) =>
            PairingConfirmResponse.fromJson(json as Map<String, dynamic>),
      );

  Future<PairedDevicesResponse> getPairedDevices(String deviceId) =>
      apiClient.get<PairedDevicesResponse>(
        '/pairing/$deviceId',
        parser: (json) =>
            PairedDevicesResponse.fromJson(json as Map<String, dynamic>),
      );
}
