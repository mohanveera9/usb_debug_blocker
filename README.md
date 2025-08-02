# usb_debug_blocker

A Flutter plugin to detect whether:

- Developer Options are enabled
- USB is connected
- USB File Transfer (MTP) mode is enabled

🔐 Designed for security-focused apps like fintech, payments, or enterprise apps that need to block access when a device is in an insecure state.

---

## 📦 Features

- ✅ Detect if **Developer Options** are enabled
- ✅ Detect if **USB cable is connected**
- ✅ Detect if **File Transfer (MTP) mode** is on

---

## 🛠 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  usb_debug_blocker: ^0.0.1
