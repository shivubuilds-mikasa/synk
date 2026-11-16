import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:synk_mobile/services/clipboard/clipboard_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  var systemClipboard = 'initial';
  final messenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  setUp(() {
    systemClipboard = 'initial';
    messenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      switch (call.method) {
        case 'Clipboard.getData':
          return {'text': systemClipboard};
        case 'Clipboard.setData':
          systemClipboard = (call.arguments as Map)['text'] as String;
          return null;
        default:
          return null;
      }
    });
  });

  tearDown(() {
    messenger.setMockMethodCallHandler(SystemChannels.platform, null);
  });

  test('polling emits new local clipboard text', () async {
    final service = ClipboardService();
    await service.read();
    final received = Completer<String>();
    service.clipboardChangeStream.listen((text) {
      if (!received.isCompleted) received.complete(text);
    });
    service.startPolling(intervalMs: 10);

    systemClipboard = 'copied on phone';
    expect(await received.future.timeout(const Duration(seconds: 1)), 'copied on phone');
    service.dispose();
  });

  test('received clipboard text updates the baseline without echoing', () async {
    final service = ClipboardService();
    await service.read();
    var emitted = false;
    service.clipboardChangeStream.listen((_) => emitted = true);

    await service.write('received from desktop');
    service.startPolling(intervalMs: 10);
    await Future<void>.delayed(const Duration(milliseconds: 40));

    expect(systemClipboard, 'received from desktop');
    expect(emitted, isFalse);
    service.dispose();
  });
}
