import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:common/model/device.dart';
import 'package:common/model/file_type.dart';
import 'package:common/model/stored_security_context.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:p2p/p2p.dart';
import 'package:p2p/src/rust/frb_generated.dart';
import 'package:refena_flutter/refena_flutter.dart';
import 'package:rhttp/rhttp.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  await RustLib.init();
  await Rhttp.init();

  runApp(
    RefenaScope(
      overrides: [
        persistenceProvider.overrideWithValue(ExamplePersistenceService()),
        deviceFullInfoProvider.overrideWithValue(
          const Device(
            ip: '0.0.0.0', // Will be updated on bind
            version: '2.0',
            port: 53317,
            https: false,
            fingerprint: 'example_fingerprint',
            alias: 'Example User',
            deviceModel: 'Flutter Example',
            deviceType: DeviceType.mobile,
            download: false, // p2p only
            signalingId: null,
            discoveryMethods: {},
          ),
        ),
        p2pSettingsProvider.overrideWithValue(
          const P2PSettings(
            sendMode: SendMode.single,
            alias: 'Example User',
            port: 53317,
            https: false,
            showToken: true,
          ),
        ),
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
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Refena {
  @override
  void initState() {
    super.initState();
    ensureRef((ref) {
      // Start Server
      ref.notifier(serverProvider).startServerFromSettings();

      // Start Discovery
      ref.redux(nearbyDevicesProvider).dispatchAsync(StartMulticastListener());
      ref.redux(nearbyDevicesProvider).dispatch(StartMulticastScan());

      // Listen for messages
      ref.notifier(serverProvider).messageStream.listen((message) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Received: $message')));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final devices = ref.watch(nearbyDevicesProvider).devices;
    final myDevice = ref.watch(deviceFullInfoProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('P2P Example')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('My Alias: ${myDevice.alias}\nMy IP: ${myDevice.ip}'),
          ),
          const Divider(),
          Expanded(
            child: devices.isEmpty
                ? const Center(child: Text('Scanning for devices...'))
                : ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      final device = devices.values.elementAt(index);
                      return ListTile(
                        leading: Icon(
                          device.deviceType == DeviceType.mobile
                              ? Icons.smartphone
                              : Icons.computer,
                        ),
                        title: Text(device.alias),
                        subtitle: Text('${device.ip}:${device.port}'),
                        trailing: ElevatedButton(
                          onPressed: () => _sendMessage(device),
                          child: const Text('Say Hi'),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage(Device target) async {
    const message = 'Hi from Example App!';
    final bytes = utf8.encode(message);

    // Create a virtual file to send. ReceiveController interprets single text file as message/preview.
    final file = CrossFile(
      name: 'message.txt',
      fileType: FileType.text,
      size: bytes.length,
      thumbnail: null,
      asset: null,
      path: null,
      bytes: Uint8List.fromList(bytes),
      lastModified: DateTime.now(),
      lastAccessed: DateTime.now(),
    );

    await ref
        .notifier(sendProvider)
        .startSession(target: target, files: [file], background: true);

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Sent "Hi"')));
    }
  }
}

class ExamplePersistenceService implements PersistenceService {
  StoredSecurityContext? _cachedContext;

  @override
  StoredSecurityContext getSecurityContext() {
    if (_cachedContext == null) {
      // In a real app, load from secure storage
      // For this example, we generate a new one on every restart
      _cachedContext = generateSecurityContext();
    }
    return _cachedContext!;
  }

  @override
  List<String>? getSignalingServers() {
    return null;
  }

  @override
  List<String>? getStunServers() {
    return null;
  }

  @override
  Future<void> setSecurityContext(StoredSecurityContext context) async {
    _cachedContext = context;
  }
}
