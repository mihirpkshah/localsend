import 'package:refena_flutter/refena_flutter.dart';
import 'package:rhttp/rhttp.dart';

final httpProvider = Provider<P2PHttpService>((ref) {
  return P2PHttpService();
});

class P2PHttpService {
  final RhttpClient longLiving;
  final RhttpClient discovery;

  P2PHttpService()
      : longLiving = RhttpClient.createSync(
          settings: const ClientSettings(
            timeoutSettings: TimeoutSettings(
              timeout: Duration(minutes: 60),
            ),
          ),
        ),
        discovery = RhttpClient.createSync(
          settings: const ClientSettings(
            timeoutSettings: TimeoutSettings(
              timeout: Duration(seconds: 2),
            ),
          ),
        );
}
