import 'package:refena_flutter/refena_flutter.dart';

final discoveryLoggerProvider = Provider<DiscoveryLogger>((ref) {
  throw UnimplementedError('Override discoveryLoggerProvider');
});

abstract class DiscoveryLogger {
  void addLog(String message);
  void clear();
}
