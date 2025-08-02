import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'usb_debug_blocker_platform_interface.dart';

/// An implementation of [UsbDebugBlockerPlatform] that uses method channels.
class MethodChannelUsbDebugBlocker extends UsbDebugBlockerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('usb_debug_blocker');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
