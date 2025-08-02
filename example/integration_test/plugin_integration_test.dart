// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing


import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:usb_debug_blocker/usb_debug_blocker.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('usb_debug_blocker test', (WidgetTester tester) async {
    final isDevEnabled = await UsbDebugBlocker.isDeveloperOptionsEnabled();
    expect(isDevEnabled, isA<bool>());

    final isUsbConnected = await UsbDebugBlocker.isUsbConnected();
    expect(isUsbConnected, isA<bool>());

    final isMtpEnabled = await UsbDebugBlocker.isMtpModeEnabled();
    expect(isMtpEnabled, isA<bool>());
  });
}
