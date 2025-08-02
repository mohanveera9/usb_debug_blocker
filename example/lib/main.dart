import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:usb_debug_blocker/usb_debug_blocker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? _isDevEnabled;
  bool? _isUsbConnected;
  bool? _isMtpEnabled;
  @override
  void initState() {
    super.initState();
    _checkUsbDebugStatus();
  }

  Future<void> _checkUsbDebugStatus() async {
    bool isDevEnabled = false;
    bool isUsbConnected = false;
    bool isMtpEnabled = false;

    try {
      isDevEnabled = await UsbDebugBlocker.isDeveloperOptionsEnabled();
      isUsbConnected = await UsbDebugBlocker.isUsbConnected();
      isMtpEnabled = await UsbDebugBlocker.isMtpModeEnabled();
    } on PlatformException catch (e) {
      print("Error checking usb connected : $e");
    }

    if (!mounted) return;

    setState(() {
      _isDevEnabled = isDevEnabled;
      _isUsbConnected = isUsbConnected;
      _isMtpEnabled = isMtpEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Developer Mode: ${_isDevEnabled == true ? "ON" : "OFF"}'),
              Text('USB Connected: ${_isUsbConnected == true ? "Yes" : "No"}'),
              Text('MTP Mode Enabled: ${_isMtpEnabled == true ? "Yes" : "No"}'),
            ],
          ),
        ),
      ),
    );
  }
}
