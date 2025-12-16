import 'package:common/model/device.dart';
import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:p2p/p2p.dart';
import 'package:refena_flutter/refena_flutter.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      RefenaScope(
        overrides: [
          deviceFullInfoProvider.overrideWithValue(
            const Device(
              ip: '0.0.0.0',
              version: '2.0',
              port: 53317,
              https: false,
              fingerprint: 'test_fingerprint',
              alias: 'Test User',
              deviceModel: 'Test Device',
              deviceType: DeviceType.mobile,
              download: false,
              signalingId: null,
              discoveryMethods: {},
            ),
          ),
          p2pSettingsProvider.overrideWithValue(
            const P2PSettings(
              sendMode: SendMode.single,
              alias: 'Test User',
              port: 53317,
              https: false,
              showToken: true,
            ),
          ),
        ],
        child: const ExampleApp(),
      ),
    );

    expect(find.text('P2P Example'), findsOneWidget);
    expect(find.textContaining('My Alias:'), findsOneWidget);
  });
}
