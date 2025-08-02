import 'package:flutter/services.dart';

class UsbDebugBlocker {
 static const MethodChannel _channel = MethodChannel('usb_debug_blocker');

 static Future<bool> isDeveloperOptionsEnabled() async {
  return await _channel.invokeMethod('isDeveloperOptionsEnabled');
 }

 static Future<bool> isUsbConnected() async {
  return await _channel.invokeMethod('isUsbConnected');
 }

 static Future<bool> isMtpModeEnabled() async {
  return await _channel.invokeMethod('isMtpMethodEnabled');
 }
}
