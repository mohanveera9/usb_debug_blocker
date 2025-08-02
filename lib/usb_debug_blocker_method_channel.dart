import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'usb_debug_blocker_platform_interface.dart';

class MethodChannelUsbDebugBlocker extends UsbDebugBlockerPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('usb_debug_blocker');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> isDeveloperOptionsEnabled() async {
    final result = await methodChannel.invokeMethod<bool>('isDeveloperOptionsEnabled');
    return result ?? false;
  }

  @override
  Future<bool> isUsbConnected() async {
    final result = await methodChannel.invokeMethod<bool>('isUsbConnected');
    return result ?? false;
  }

  @override
  Future<bool> isMtpModeEnabled() async {
    // Make sure this matches your Android implementation exactly
    final result = await methodChannel.invokeMethod<bool>('isMtpModeEnabled');
    return result ?? false;
  }
}