package com.mohanveera.usb_debug_blocker

import android.content.Context
import android.content.IntentFilter
import android.provider.Settings
import android.util.Log

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class UsbDebugBlockerPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    context = binding.applicationContext
    channel = MethodChannel(binding.binaryMessenger, "usb_debug_blocker")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "isDeveloperOptionsEnabled" -> {
        val enabled = try {
          Settings.Global.getInt(context.contentResolver, Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, 0) == 1
        } catch (e: Exception) {
          Log.e("UsbDebugBlocker", "Error checking Developer Options", e)
          false
        }
        result.success(enabled)
      }

      "isUsbConnected" -> {
        val intent = context.registerReceiver(null, IntentFilter("android.hardware.usb.action.USB_STATE"))
        val connected = intent?.getBooleanExtra("connected", false) ?: false
        result.success(connected)
      }

      "isMtpModeEnabled" -> {
        val intent = context.registerReceiver(null, IntentFilter("android.hardware.usb.action.USB_STATE"))
        val isMtp = intent?.getBooleanExtra("mtp", false) ?: false
        result.success(isMtp)
      }

      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
