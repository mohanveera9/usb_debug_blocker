import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'usb_debug_blocker_method_channel.dart';

abstract class UsbDebugBlockerPlatform extends PlatformInterface {
  /// Constructs a UsbDebugBlockerPlatform.
  UsbDebugBlockerPlatform() : super(token: _token);

  static final Object _token = Object();

  static UsbDebugBlockerPlatform _instance = MethodChannelUsbDebugBlocker();

  /// The default instance of [UsbDebugBlockerPlatform] to use.
  ///
  /// Defaults to [MethodChannelUsbDebugBlocker].
  static UsbDebugBlockerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UsbDebugBlockerPlatform] when
  /// they register themselves.
  static set instance(UsbDebugBlockerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
