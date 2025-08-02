import 'package:flutter_test/flutter_test.dart';
import 'package:usb_debug_blocker/usb_debug_blocker.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('isDeveloperOptionsEnabled returns a bool', () async {
    final isDevEnabled = await UsbDebugBlocker.isDeveloperOptionsEnabled();
    expect(isDevEnabled, isA<bool>());
  });

  test('isUsbConnected returns a bool', () async {
    final isUsbConnected = await UsbDebugBlocker.isUsbConnected();
    expect(isUsbConnected, isA<bool>());
  });

  test('isMtpModeEnabled returns a bool', () async {
    final isMtpEnabled = await UsbDebugBlocker.isMtpModeEnabled();
    expect(isMtpEnabled, isA<bool>());
  });
}
