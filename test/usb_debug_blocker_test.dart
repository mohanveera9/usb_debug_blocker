import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:usb_debug_blocker/usb_debug_blocker_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MethodChannelUsbDebugBlocker platform = MethodChannelUsbDebugBlocker();
  const MethodChannel channel = MethodChannel('usb_debug_blocker');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'isDeveloperOptionsEnabled':
            return true;
          case 'isUsbConnected':
            return false;
          case 'isMtpModeEnabled':
            return true;
          default:
            return null;
        }
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('isDeveloperOptionsEnabled returns true', () async {
    expect(await platform.isDeveloperOptionsEnabled(), true);
  });

  test('isUsbConnected returns false', () async {
    expect(await platform.isUsbConnected(), false);
  });

  test('isMtpModeEnabled returns true', () async {
    expect(await platform.isMtpModeEnabled(), true);
  });
}