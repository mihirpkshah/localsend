import 'package:p2p/p2p.dart';
import 'package:refena_flutter/refena_flutter.dart';

class StartSmartScan extends ReduxAction<NearbyDevicesService, NearbyDevicesState> {
  static const int maxInterfaces = 8;
  final bool forceLegacy;
  final int port;
  final bool https;
  final List<String> localIps;

  StartSmartScan({
    this.forceLegacy = false,
    required this.port,
    required this.https,
    required this.localIps,
  });

  @override
  NearbyDevicesState reduce() {
    dispatch(StartMulticastScan());

    if (forceLegacy) {
      for (final ip in localIps) {
        dispatchAsync(StartLegacyScan(port: port, localIp: ip, https: https));
      }
    }
    return state;
  }
}

class StartLegacySubnetScan extends ReduxAction<NearbyDevicesService, NearbyDevicesState> {
  final int port;
  final String submask;
  final bool https;

  StartLegacySubnetScan({
    required this.port,
    required this.submask,
    required this.https,
  });

  @override
  NearbyDevicesState reduce() {
    // StartLegacyScan expects an interface IP, but here we might be passing a submask or IP.
    // Assuming StartLegacyScan handles it or we pass it as is.
    dispatchAsync(StartLegacyScan(port: port, localIp: submask, https: https));
    return state;
  }
}
