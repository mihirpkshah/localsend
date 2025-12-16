import 'dart:convert';
import 'dart:typed_data';

import 'package:common/model/device.dart';
import 'package:common/model/file_type.dart';
import 'package:flutter/material.dart';
import 'package:p2p/p2p.dart';
import 'package:refena_flutter/refena_flutter.dart';

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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Received: $message'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final devices = ref.watch(nearbyDevicesProvider).devices;
    final myDevice = ref.watch(deviceFullInfoProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('LocalSend P2P'), centerTitle: true),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _MyDeviceCard(device: myDevice)),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Nearby Devices',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (devices.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Scanning for devices...'),
                  ],
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final device = devices.values.elementAt(index);
                return _DeviceTile(
                  device: device,
                  onTap: () => _sendMessage(device),
                );
              }, childCount: devices.length),
            ),
        ],
      ),
    );
  }

  Future<void> _sendMessage(Device target) async {
    final controller = TextEditingController();
    final message = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Send Message to ${target.alias}'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Type your message...',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Send'),
          ),
        ],
      ),
    );

    if (message == null || message.trim().isEmpty) return;

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sent "$message" to ${target.alias}')),
      );
    }
  }
}

class _MyDeviceCard extends StatelessWidget {
  final Device device;

  const _MyDeviceCard({required this.device});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  device.deviceType == DeviceType.mobile
                      ? Icons.smartphone
                      : Icons.computer,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        device.alias,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        '${device.ip}:${device.port}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DeviceTile extends StatelessWidget {
  final Device device;
  final VoidCallback onTap;

  const _DeviceTile({required this.device, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: Icon(
            device.deviceType == DeviceType.mobile
                ? Icons.smartphone
                : Icons.computer,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
        title: Text(
          device.alias,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text('${device.ip}:${device.port}'),
        trailing: const Icon(Icons.send_rounded),
        onTap: onTap,
      ),
    );
  }
}
