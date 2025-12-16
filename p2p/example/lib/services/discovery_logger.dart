import 'package:flutter/foundation.dart';
import 'package:p2p/p2p.dart';

/// A simple implementation of [DiscoveryLogger] that prints to console.
class ExampleDiscoveryLogger implements DiscoveryLogger {
  @override
  void addLog(String message) {
    if (kDebugMode) {
      print('[Discovery] $message');
    }
  }

  @override
  void clear() {
    // No-op
  }
}
