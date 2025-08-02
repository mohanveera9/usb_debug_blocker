import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'usb_debug_blocker_method_channel.dart';

abstract class UsbDebugBlockerPlatform extends PlatformInterface {
  UsbDebugBlockerPlatform() : super(token: _token);

  static final Object _token = Object();

  static UsbDebugBlockerPlatform _instance = MethodChannelUsbDebugBlocker();

  static UsbDebugBlockerPlatform get instance => _instance;

  static set instance(UsbDebugBlockerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('getPlatformVersion() has not been implemented.');
  }

  Future<bool> isDeveloperOptionsEnabled() {
    throw UnimplementedError('isDeveloperOptionsEnabled() has not been implemented.');
  }

  Future<bool> isUsbConnected() {
    throw UnimplementedError('isUsbConnected() has not been implemented.');
  }

  Future<bool> isMtpModeEnabled() {
    throw UnimplementedError('isMtpModeEnabled() has not been implemented.');
  }
}
