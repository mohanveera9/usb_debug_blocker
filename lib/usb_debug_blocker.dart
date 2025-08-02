import 'usb_debug_blocker_platform_interface.dart';

class UsbDebugBlocker {
  static Future<String?> getPlatformVersion() {
    return UsbDebugBlockerPlatform.instance.getPlatformVersion();
  }

  static Future<bool> isDeveloperOptionsEnabled() {
    return UsbDebugBlockerPlatform.instance.isDeveloperOptionsEnabled();
  }

  static Future<bool> isUsbConnected() {
    return UsbDebugBlockerPlatform.instance.isUsbConnected();
  }

  static Future<bool> isMtpModeEnabled() {
    return UsbDebugBlockerPlatform.instance.isMtpModeEnabled();
  }
}
