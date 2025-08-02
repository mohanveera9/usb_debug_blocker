# 🔒 USB Debug Blocker

[![pub package](https://img.shields.io/pub/v/usb_debug_blocker.svg)](https://pub.dev/packages/usb_debug_blocker)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-android-green.svg)](https://flutter.dev)

A Flutter plugin designed for **security-focused applications** that need to detect and block access when a device is in potentially insecure states. Perfect for fintech, banking, payment processing, and enterprise applications.

---

## 🚨 Why Use This Plugin?

In security-sensitive applications, certain device states can pose risks:

- **Developer Options Enabled**: Allows USB debugging, mock locations, and other debugging features
- **USB Connected**: Device might be connected to a potentially compromised computer
- **MTP Mode Active**: Files can be transferred, potentially exposing sensitive data

This plugin helps you detect these states and implement appropriate security measures.

---

## ✨ Features

| Feature | Description | Status |
|---------|-------------|--------|
| 🛠️ **Developer Options Detection** | Detects if Android Developer Options are enabled | ✅ |
| 🔌 **USB Connection Detection** | Checks if device is connected via USB cable | ✅ |
| 📁 **MTP Mode Detection** | Identifies if File Transfer (MTP) mode is active | ✅ |
| 🔒 **Security Focused** | Built specifically for security-sensitive apps | ✅ |
| ⚡ **Lightweight** | Minimal impact on app performance | ✅ |
| 🎯 **Easy Integration** | Simple API with boolean returns | ✅ |

---

## 🛠 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  usb_debug_blocker: ^0.0.1
```

Then run:

```bash
flutter pub get
```

---

## 🚀 Quick Start

### Basic Usage

```dart
import 'package:usb_debug_blocker/usb_debug_blocker.dart';

class SecurityCheck extends StatefulWidget {
  @override
  _SecurityCheckState createState() => _SecurityCheckState();
}

class _SecurityCheckState extends State<SecurityCheck> {
  bool? _isDevEnabled;
  bool? _isUsbConnected;
  bool? _isMtpEnabled;

  @override
  void initState() {
    super.initState();
    _checkSecurityStatus();
  }

  Future<void> _checkSecurityStatus() async {
    try {
      final isDevEnabled = await UsbDebugBlocker.isDeveloperOptionsEnabled();
      final isUsbConnected = await UsbDebugBlocker.isUsbConnected();
      final isMtpEnabled = await UsbDebugBlocker.isMtpModeEnabled();

      setState(() {
        _isDevEnabled = isDevEnabled;
        _isUsbConnected = isUsbConnected;
        _isMtpEnabled = isMtpEnabled;
      });
    } catch (e) {
      print('Security check error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Security Status')),
      body: Column(
        children: [
          _buildStatusCard('Developer Options', _isDevEnabled),
          _buildStatusCard('USB Connected', _isUsbConnected),
          _buildStatusCard('MTP Mode', _isMtpEnabled),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String title, bool? status) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Icon(
          status == true ? Icons.warning : Icons.check_circle,
          color: status == true ? Colors.red : Colors.green,
        ),
        subtitle: Text(status == true ? 'DETECTED' : 'Safe'),
      ),
    );
  }
}
```

### Advanced Security Implementation

```dart
class SecurityService {
  static Future<bool> isDeviceSecure() async {
    final isDevEnabled = await UsbDebugBlocker.isDeveloperOptionsEnabled();
    final isUsbConnected = await UsbDebugBlocker.isUsbConnected();
    final isMtpEnabled = await UsbDebugBlocker.isMtpModeEnabled();

    // Device is secure if none of these are active
    return !isDevEnabled && !isUsbConnected && !isMtpEnabled;
  }

  static Future<void> enforceSecurityPolicy() async {
    final isSecure = await isDeviceSecure();
    
    if (!isSecure) {
      // Block access to sensitive features
      throw SecurityException('Device is in an insecure state');
    }
  }
}

// Usage in your app
class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: SecurityService.isDeviceSecure(),
      builder: (context, snapshot) {
        if (snapshot.data == false) {
          return SecurityWarningScreen();
        }
        return PaymentFormScreen();
      },
    );
  }
}
```

---

## 📚 API Reference

### Methods

#### `isDeveloperOptionsEnabled()`
```dart
Future<bool> isDeveloperOptionsEnabled()
```
**Returns:** `true` if Android Developer Options are enabled, `false` otherwise.

**Use Case:** Block access when debugging features might be available.

---

#### `isUsbConnected()`
```dart
Future<bool> isUsbConnected()
```
**Returns:** `true` if device is connected via USB cable, `false` otherwise.

**Use Case:** Prevent operations when device might be connected to untrusted computers.

---

#### `isMtpModeEnabled()`
```dart
Future<bool> isMtpModeEnabled()
```
**Returns:** `true` if USB File Transfer (MTP) mode is active, `false` otherwise.

**Use Case:** Block file operations when device storage is accessible externally.

---

## 🔧 Configuration

### Android Permissions

Add these permissions to your `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Required for USB state detection -->
    <uses-permission android:name="android.permission.ACCESS_USB_STATE" />
    
    <!-- Optional: For enhanced USB detection -->
    <uses-permission android:name="android.permission.MANAGE_USB" />
    
    <application>
        <!-- Your app configuration -->
    </application>
</manifest>
```

### Minimum SDK Version

Update your `android/app/build.gradle`:

```gradle
android {
    defaultConfig {
        minSdkVersion 21  // Android 5.0 or higher
        // ... other configurations
    }
}
```

---

## 🎯 Use Cases

### 🏦 Banking Applications
```dart
class BankingApp {
  Future<void> performTransaction() async {
    // Check security before sensitive operations
    final isSecure = await SecurityService.isDeviceSecure();
    if (!isSecure) {
      showSecurityAlert();
      return;
    }
    
    // Proceed with transaction
    processPayment();
  }
}
```

### 💳 Payment Processing
```dart
class PaymentProcessor {
  Future<void> processPayment() async {
    if (await UsbDebugBlocker.isDeveloperOptionsEnabled()) {
      throw PaymentException('Developer mode detected');
    }
    
    if (await UsbDebugBlocker.isUsbConnected()) {
      showWarning('USB connection detected. Disconnect for security.');
      return;
    }
    
    // Process payment safely
  }
}
```

### 🏢 Enterprise Security
```dart
class EnterpriseSecurityManager {
  Future<bool> validateDeviceCompliance() async {
    final checks = await Future.wait([
      UsbDebugBlocker.isDeveloperOptionsEnabled(),
      UsbDebugBlocker.isUsbConnected(),
      UsbDebugBlocker.isMtpModeEnabled(),
    ]);
    
    // Log security events
    logSecurityEvent(checks);
    
    // Return compliance status
    return !checks.any((check) => check == true);
  }
}
```

---

## ⚠️ Security Considerations

### Best Practices

1. **Regular Checks**: Implement periodic security checks, not just on app launch
2. **Graceful Degradation**: Disable sensitive features rather than blocking the entire app
3. **User Education**: Explain why certain features are blocked
4. **Logging**: Keep security event logs for auditing

### Limitations

- **Root Detection**: This plugin doesn't detect rooted devices (consider additional security measures)
- **iOS Support**: Currently Android-only (iOS has different security models)
- **Bypass Possibilities**: Determined attackers might find workarounds

---

## 🐛 Troubleshooting

### Common Issues

#### Issue: "MissingPluginException"
**Solution:** Ensure you've run `flutter clean` and `flutter pub get` after installation.

#### Issue: MTP detection not working
**Solution:** 
1. Ensure USB debugging is enabled for testing
2. Try connecting USB and selecting "File Transfer" mode
3. Check if your device supports MTP

#### Issue: False positives
**Solution:** Test on different devices and Android versions as behavior may vary.

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### Development Setup

```bash
# Clone the repository
git clone https://github.com/mohanveera9s/usb_debug_blocker.git

# Install dependencies
flutter pub get

# Run example app
cd example
flutter run
```

### Running Tests

```bash
# Run Dart tests
flutter test

# Run integration tests
flutter test integration_test/
```

### Submitting Changes

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📈 Roadmap

- [ ] Root/Jailbreak detection
- [ ] Additional security checks
- [ ] Real-time monitoring
- [ ] Security event callbacks
- [ ] Configurable security policies

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2025 USB Debug Blocker

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 🙏 Acknowledgments

- Thanks to the Flutter team for the excellent plugin architecture
- Inspired by security requirements in fintech applications
- Community feedback and contributions

---

## 📞 Support

- 🐛 **Issues**: [GitHub Issues](https://github.com/yourusername/usb_debug_blocker/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/yourusername/usb_debug_blocker/discussions)
- 📧 **Email**: support@yourcompany.com

---

<div align="center">
  <p>Made with ❤️ for secure Flutter applications</p>
  <p>
    <a href="https://pub.dev/packages/usb_debug_blocker">pub.dev</a> •
    <a href="https://github.com/mohanveera9/usb_debug_blocker">GitHub</a>
  </p>
</div>