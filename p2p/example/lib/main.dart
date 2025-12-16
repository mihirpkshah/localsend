import 'dart:async';

import 'package:common/isolate.dart';
import 'package:common/model/device_info_result.dart';
import 'package:common/model/device.dart';
import 'package:common/model/dto/multicast_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:p2p/p2p.dart';
import 'package:p2p/src/network/discovery_logger.dart';
import 'package:p2p/src/rust/frb_generated.dart';
import 'package:refena_flutter/refena_flutter.dart';
import 'package:rhttp/rhttp.dart';

import 'pages/home_page.dart';
import 'rhttp_wrapper.dart';
import 'services/discovery_logger.dart';
import 'services/favorites_service.dart';
import 'services/persistence_service.dart';

Future<void> main() async {
  // Setup logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });

  // Initialize Rust logic
  await RustLib.init();
  await Rhttp.init(); // Initialize HTTP client (required for web)

  // Initialize services
  final persistenceService = ExamplePersistenceService();
  final securityContext = persistenceService.getSecurityContext();

  runApp(
    RefenaScope(
      overrides: [
        // 1. Persistence Provider: Manages security context (keys/certs)
        persistenceProvider.overrideWithValue(persistenceService),

        // 2. Device Info Provider: Defines this device's identity
        deviceFullInfoProvider.overrideWithValue(
          const Device(
            ip: '0.0.0.0', // Will be updated on bind
            version: '2.0',
            port: 53317,
            https: true,
            fingerprint: 'example_fingerprint',
            alias: 'Example User',
            deviceModel: 'Flutter Example',
            deviceType: DeviceType.desktop,
            download: true, // p2p only: no download manager
            signalingId: null,
            discoveryMethods: {},
          ),
        ),

        // 3. P2P Settings: Configuration for the P2P stack
        p2pSettingsProvider.overrideWithValue(
          const P2PSettings(
            sendMode: SendMode.single,
            alias: 'Example User',
            port: 53317,
            https: true,
            showToken: true,
          ),
        ),

        // 4. Favorites Service: Manages favorite devices (empty for example)
        favoritesProvider.overrideWithNotifier(
          (ref) => ExampleFavoritesService(),
        ),

        // 5. Discovery Logger: Logs discovery events
        discoveryLoggerProvider.overrideWithValue(ExampleDiscoveryLogger()),

        // 6. Parent Isolate Provider: Connects UI to background isolates (if any)
        // and initializes the SyncState for shared logic.
        parentIsolateProvider.overrideWithNotifier((ref) {
          return IsolateController(
            initialState: ParentIsolateState.initial(
              SyncState(
                init: () async {
                  await Rhttp.init();
                },
                rootIsolateToken: RootIsolateToken.instance!,
                httpClientFactory: RhttpWrapper.create,
                securityContext: securityContext,
                deviceInfo: DeviceInfoResult(
                  deviceType: DeviceType.desktop,
                  deviceModel: 'Flutter Example',
                  androidSdkInt: null,
                ),
                alias: 'Example User',
                port: 53317,
                networkWhitelist: null,
                networkBlacklist: null,
                protocol: ProtocolType.https,
                multicastGroup: '224.0.0.167',
                discoveryTimeout: 500,
                serverRunning: true,
                download: false,
              ),
            ),
          );
        }),
      ],
      child: const ExampleApp(),
    ),
  );
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'P2P Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
