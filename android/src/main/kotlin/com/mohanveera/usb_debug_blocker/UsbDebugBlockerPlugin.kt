package com.mohanveera.usb_debug_blocker

import android.content.Context
import android.os.Build
import android.provider.Settings
import android.hardware.usb.UsbManager
import android.os.Environment
import android.content.Intent
import android.content.IntentFilter
import android.content.BroadcastReceiver
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.BatteryManager

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class UsbDebugBlockerPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {

  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "usb_debug_blocker")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
    when (call.method) {
      "isDeveloperOptionsEnabled" -> {
        val devSettings = Settings.Secure.getInt(context.contentResolver, Settings.Secure.DEVELOPMENT_SETTINGS_ENABLED, 0)
        result.success(devSettings == 1)
      }
      "isUsbConnected" -> {
        result.success(isUsbConnectedToComputer())
      }
      "isMtpModeEnabled" -> {
        result.success(isMtpModeActive())
      }
      else -> result.notImplemented()
    }
  }

  private fun isUsbConnectedToComputer(): Boolean {
    return try {
      val batteryManager = context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
      val chargePlug = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_STATUS)
      
      // Check if charging via USB
      val intentFilter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
      val batteryStatus = context.registerReceiver(null, intentFilter)
      val plugType = batteryStatus?.getIntExtra(BatteryManager.EXTRA_PLUGGED, -1) ?: -1
      
      plugType == BatteryManager.BATTERY_PLUGGED_USB
    } catch (e: Exception) {
      false
    }
  }

  private fun isMtpModeActive(): Boolean {
    return try {
      // Check if USB is connected first
      if (!isUsbConnectedToComputer()) {
        return false
      }

      // Try to read system properties for USB configuration
      val usbConfig = getSystemProperty("sys.usb.config")
      val usbState = getSystemProperty("sys.usb.state")
      
      // Check if MTP is mentioned in USB configuration
      if (usbConfig.contains("mtp") || usbState.contains("mtp")) {
        return true
      }

      // Fallback: If USB is connected and storage is available, 
      // it's likely in a file transfer mode
      Environment.getExternalStorageState() == Environment.MEDIA_MOUNTED

    } catch (e: Exception) {
      false
    }
  }

  private fun getSystemProperty(key: String): String {
    return try {
      val systemProperties = Class.forName("android.os.SystemProperties")
      val get = systemProperties.getMethod("get", String::class.java)
      get.invoke(null, key) as String? ?: ""
    } catch (e: Exception) {
      ""
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}