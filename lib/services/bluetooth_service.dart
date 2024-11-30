import 'package:flutter_blue/flutter_blue.dart';

class BluetoothService {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> foundDevices = [];

  /// Connect to a mock Bluetooth device based on device name.
  Future<bool> connectMockDevice(
    String deviceName,
    List<Map<String, String>> mockDevices,
  ) async {
    try {
      // Find mock device by name
      var device = mockDevices.firstWhere(
        (device) => device['deviceName'] == deviceName,
        orElse: () => {},
      );

      if (device.isEmpty) {
        print("Device not found: $deviceName");
        return false;
      }

      // Simulate successful connection
      print("Mock device connected: $deviceName");
      return true;
    } catch (e) {
      print("Failed to connect to mock Bluetooth device: $e");
      return false;
    }
  }

  Future<void> scanForDevices() async {
    await Future.delayed(Duration(seconds: 1));
  }

  /// Connect to a Bluetooth device.
  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      print("Connecting to ${device.name}...");
      await device.connect();
      print("Successfully connected to ${device.name}.");
    } catch (e) {
      print("Failed to connect to ${device.name}: $e");
    }
  }

  /// Disconnect from a Bluetooth device.
  Future<void> disconnectFromDevice(BluetoothDevice device) async {
    try {
      print("Disconnecting from ${device.name}...");
      await device.disconnect();
      print("Successfully disconnected from ${device.name}.");
    } catch (e) {
      print("Failed to disconnect from ${device.name}: $e");
    }
  }

  /// Dispose resources and clean up.
  Future<void> dispose() async {
    try {
      print("Disposing Bluetooth resources...");
      await flutterBlue.stopScan();
      print("Bluetooth resources disposed.");
    } catch (e) {
      print("Error during disposal: $e");
    }
  }
}
