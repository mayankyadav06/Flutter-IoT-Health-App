import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceProvider with ChangeNotifier {
  // List to hold mock bluetooth devices
  List<Map<String, String>> _bluetoothDevices = [
    {'deviceName': 'Blue 1', 'connectionType': 'Bluetooth'},
    {'deviceName': 'Blue 2', 'connectionType': 'Bluetooth'},
  ];

  // List to hold mock wifi devices
  List<Map<String, String>> _wifiDevices = [
    {'deviceName': 'Wifi 1', 'connectionType': 'Wi-Fi', 'password': 'pass12'},
    {'deviceName': 'Wifi 2', 'connectionType': 'Wi-Fi', 'password': 'pass34'},
  ];

  // Getter for devices list
  List<Map<String, String>> get bluetoothDevices => _bluetoothDevices;
  List<Map<String, String>> get wifiDevices => _wifiDevices;

  // Current device details
  String _deviceName = '';
  String? _selectedConnectionType;

  String get deviceName => _deviceName;
  String? get selectedConnectionType => _selectedConnectionType;

  // Method to set the device name
  void setDeviceName(String name) {
    _deviceName = name;
    notifyListeners();
  }

  // Method to set the connection type
  void setConnectionType(String? type) {
    _selectedConnectionType = type;
    notifyListeners();
  }

  // Method to clear the current device input fields
  void clearDevice() {
    _deviceName = '';
    _selectedConnectionType = null;
    notifyListeners();
  }

  // Method to add a new device to the list
  void addDevice() {
    // Based on connection type add the device to respective dummy list
    if (_deviceName.isNotEmpty && _selectedConnectionType != null) {
      _selectedConnectionType == "Wi-Fi"
          ? _wifiDevices.add({
              'deviceName': _deviceName,
              'connectionType': _selectedConnectionType!,
              'password': 'pass'
            })
          : _bluetoothDevices.add({
              'deviceName': _deviceName,
              'connectionType': _selectedConnectionType!,
            });
      notifyListeners();
    }
  }
}
