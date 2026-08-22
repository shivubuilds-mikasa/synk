// Widget tests for Synk Mobile.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:synk_mobile/main.dart';

void main() {
  testWidgets('App builds successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SynkMobileApp());

    // Verify that the app builds without errors.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}