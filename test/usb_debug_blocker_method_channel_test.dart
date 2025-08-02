import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:usb_debug_blocker/usb_debug_blocker_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelUsbDebugBlocker platform = MethodChannelUsbDebugBlocker();
  const MethodChannel channel = MethodChannel('usb_debug_blocker');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
