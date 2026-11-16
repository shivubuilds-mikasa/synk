import 'package:flutter_test/flutter_test.dart';
import 'package:synk_mobile/models/sync/sync_message.dart';

void main() {
  group('server protocol decoding', () {
    for (final authType in ['auth_success', 'auth.success']) {
      test('decodes $authType with the backend snake_case fields', () {
        final message = ServerMessage.fromJson({
          'type': authType,
          'version': 1,
          'message_id': 'message-1',
          'device_id': 'device-1',
          'timestamp': '2026-11-17T00:00:00Z',
          'payload': <String, dynamic>{},
        });

        expect(
          message.maybeMap(
            authSuccess: (value) => value.message.deviceId,
            orElse: () => null,
          ),
          'device-1',
        );
      });
    }

    test('decodes snake_case clipboard relay fields and payload', () {
      final message = ServerMessage.fromJson({
        'type': 'clipboard.update.relay',
        'version': 1,
        'message_id': 'message-2',
        'device_id': 'device-2',
        'timestamp': '2026-11-17T00:00:00Z',
        'source_device_id': 'device-1',
        'payload': {'content_type': 'text', 'text': 'hello'},
      });

      expect(
        message.maybeMap(
          clipboardUpdateRelay: (value) => (
            value.message.sourceDeviceId,
            value.message.payload.text,
          ),
          orElse: () => null,
        ),
        ('device-1', 'hello'),
      );
    });
  });

  test('serializes client messages with backend wire names', () {
    final message = ClipboardUpdateMessage(
      type: SyncMessageType.clipboardUpdate,
      messageId: 'message-3',
      deviceId: 'device-1',
      timestamp: '2026-11-17T00:00:00Z',
      payload: const ClipboardPayload(text: 'hello'),
    ).toJson();

    expect(message['type'], 'clipboard.update');
    expect(message['message_id'], 'message-3');
    expect(message['device_id'], 'device-1');
    expect(message['payload'], {'content_type': 'text', 'text': 'hello'});
  });
}
