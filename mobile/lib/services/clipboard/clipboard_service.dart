// ignore_for_file: dangling_library_doc_comments, unnecessary_library_name

/// Clipboard service for Synk mobile.
///
/// Provides a platform-agnostic interface to the system clipboard with
/// change detection and deduplication of repeated content.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Service for interacting with the system clipboard.
///
/// Tracks the last clipboard value to detect changes and prevent
/// re-syncing the same content repeatedly.
class ClipboardService {
  String? _lastReadValue;
  final _changeController = StreamController<String>.broadcast();
  Timer? _pollingTimer;

  /// Stream of clipboard changes (new content only).
  Stream<String> get clipboardChangeStream => _changeController.stream;

  /// Current clipboard value (last read).
  String? get lastReadValue => _lastReadValue;

  /// Reads the current clipboard content.
  ///
  /// Returns empty string if clipboard is empty or unavailable.
  Future<String> read() async {
    try {
      final value = await Clipboard.getData('text/plain');
      final text = value?.text ?? '';
      _lastReadValue = text;
      return text;
    } catch (e) {
      debugPrint('Failed to read clipboard: $e');
      return '';
    }
  }

  /// Writes content to the clipboard.
  ///
  /// [text] - The text to write.
  /// [markAsLast] - Whether to update _lastReadValue (set false for incoming sync to prevent loop)
  Future<bool> write(String text, {bool markAsLast = true}) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      if (markAsLast) {
        _lastReadValue = text;
      }
      return true;
    } catch (e) {
      debugPrint('Failed to write clipboard: $e');
      return false;
    }
  }

  /// Starts polling for clipboard changes.
  ///
  /// [intervalMs] - Polling interval in milliseconds.
  void startPolling({int intervalMs = 1000}) {
    stopPolling();
    _pollingTimer = Timer.periodic(
      Duration(milliseconds: intervalMs),
      (_) async {
        final current = await read();
        if (current.isNotEmpty && current != _lastReadValue) {
          _lastReadValue = current;
          _changeController.add(current);
        }
      },
    );
  }

  /// Stops polling for clipboard changes.
  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  /// Disposes resources.
  void dispose() {
    stopPolling();
    _changeController.close();
  }
}