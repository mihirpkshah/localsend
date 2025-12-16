import 'package:p2p/src/model/send_mode.dart';
import 'package:refena_flutter/refena_flutter.dart';

final p2pSettingsProvider = Provider<P2PSettings>((ref) {
  throw 'P2PSettings not initialized. Override p2pSettingsProvider.';
});

class P2PSettings {
  final SendMode sendMode;
  final String alias;
  final int port;
  final bool https;
  final bool showToken;

  const P2PSettings({
    required this.sendMode,
    required this.alias,
    required this.port,
    required this.https,
    required this.showToken,
  });
}
