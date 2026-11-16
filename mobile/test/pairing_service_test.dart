import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:synk_mobile/core/network/api_client.dart';
import 'package:synk_mobile/services/pairing_service.dart';

void main() {
  test('creates, confirms, and lists authenticated device pairings', () async {
    final requests = <http.Request>[];
    final client = ApiClient(
      httpClient: MockClient((request) async {
        requests.add(request);
        if (request.url.path.endsWith('/pairing/create')) {
          return http.Response(
            jsonEncode({
              'code': '012345',
              'expires_at': '2026-11-16T10:05:00Z',
              'device_id': 'initiator',
            }),
            201,
          );
        }
        if (request.url.path.endsWith('/pairing/confirm')) {
          return http.Response(
            jsonEncode({
              'paired_device': {
                'device_id': 'other',
                'device_name': 'Desktop',
                'device_type': 'desktop',
              },
              'this_device': {
                'device_id': 'initiator',
                'device_name': 'Phone',
                'device_type': 'mobile',
              },
            }),
            200,
          );
        }
        return http.Response(
          jsonEncode({
            'device_id': 'initiator',
            'paired_devices': [
              {
                'device_id': 'other',
                'device_name': 'Desktop',
                'device_type': 'desktop',
              },
            ],
          }),
          200,
        );
      }),
    )..setAuthToken('secret-token');
    final service = PairingService(apiClient: client);

    final created = await service.createCode();
    expect(created.code, '012345');
    final confirmed = await service.confirmCode(created.code);
    expect(confirmed.pairedDevice.deviceName, 'Desktop');
    final devices = await service.getPairedDevices('initiator');
    expect(devices.pairedDevices.single.deviceId, 'other');

    expect(requests, hasLength(3));
    expect(
      requests.every(
        (request) => request.headers['Authorization'] == 'Bearer secret-token',
      ),
      isTrue,
    );
    expect(jsonDecode(requests[1].body), {'code': '012345'});
    expect(requests[2].url.path, endsWith('/pairing/initiator'));

    client.close();
  });
}
