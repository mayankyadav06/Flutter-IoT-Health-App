import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:iot_health_app/providers/wifi_info_provider.dart';
import 'package:iot_health_app/widgets/device_item.dart';
// import '../providers/bluetooth_provider.dart';
import '../providers/device_provider.dart';
import '../providers/loading_provider.dart';
import '../services/bluetooth_service.dart' as bs;
import '../services/wifi_service.dart';
import 'data_visualisation_screen.dart';

class DevicesScreen extends StatefulWidget {
  final String connectionType;

  const DevicesScreen({
    super.key,
    required this.connectionType,
  });

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  final _wifiService = WiFiService(); // Instance of Wi-Fi service
  final bs.BluetoothService _bluetoothService =
      bs.BluetoothService(); // Instance of Bluetooth Service

  @override
  void initState() {
    super.initState();

    if (widget.connectionType == "Wi-Fi") {
      // Simulating scanning Wifi devices when the connection type is Wifi
      Provider.of<LoadingProvider>(context, listen: false).startLoading();
      _wifiService.discoverNetworks();
      _loadWiFiDevices();
    } else if (widget.connectionType == "Bluetooth") {
      // Simulating discovery of Bluetooth devices when the connection type is Bluetooth
      Provider.of<LoadingProvider>(context, listen: false).startLoading();
      _discoverBluetoothDevices();
    }
  }

  // Function to discover Bluetooth devices using FlutterBlue
  Future<void> _discoverBluetoothDevices() async {
    // Simulate the delay and stop loading after 2 seconds
    Future.delayed(const Duration(seconds: 2), () async {
      Provider.of<LoadingProvider>(context, listen: false).stopLoading();
      await _bluetoothService.scanForDevices();
    });
  }

  Future<void> _loadWiFiDevices() async {
    // Simulate the network discovery process by awaiting the delay
    await _wifiService.discoverNetworks();

    // Simulate the delay and stop loading after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Provider.of<LoadingProvider>(context, listen: false).stopLoading();
    });

    Provider.of<WiFiInfoProvider>(context, listen: false)
        .fetchCurrentWifiInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          widget.connectionType,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Consumer<LoadingProvider>(
        builder: (context, loadingProvider, child) {
          return Center(
            child: loadingProvider.isLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Scanning for devices...'),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Show Wi-Fi information only for Wi-Fi connection type
                        if (widget.connectionType == "Wi-Fi") ...[
                          const Text(
                            "Current Wi-Fi Information",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Consumer<WiFiInfoProvider>(
                            builder: (context, wifiInfoProvider, child) {
                              if (wifiInfoProvider.isLoading) {
                                return const Text(
                                    "Fetching Wi-Fi information...");
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Wi-Fi Name: ${wifiInfoProvider.wifiName}"),
                                  ],
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                        // Available Mock Devices
                        const Text(
                          "Available Devices",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Consumer<DeviceProvider>(
                            builder: (context, deviceProvider, child) {
                              final filteredDevices =
                                  widget.connectionType == "Wi-Fi"
                                      ? deviceProvider.wifiDevices
                                      : deviceProvider.bluetoothDevices;

                              if (filteredDevices.isEmpty) {
                                return const Center(
                                  child: Text(
                                    "No devices available. Please add a device.",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                );
                              }

                              // Building list of mock devices
                              return ListView.builder(
                                itemCount: filteredDevices.length,
                                itemBuilder: (context, index) {
                                  final device = filteredDevices[index];
                                  return DeviceItem(
                                    deviceName: device['deviceName']!,
                                    connectionType: device['connectionType'],
                                    onConnect: () =>
                                        widget.connectionType == "Wi-Fi"
                                            ? _connectWiFiDevice(
                                                context, device['deviceName']!)
                                            : _connectMockBluetoothDevice(
                                                context, device['deviceName']!),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  // Simulating connection with dummy bluetooth device
  void _connectMockBluetoothDevice(BuildContext, String deviceName) async {
    final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
    final devices = deviceProvider.bluetoothDevices;
    final isConnected =
        await _bluetoothService.connectMockDevice(deviceName, devices);

    if (isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Connected to '$deviceName'"),
        ),
      );
      // Navigate to data visualization screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DataVisualisationScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to connect to '$deviceName'")),
      );
    }
  }

  // Simulating connection with dummy wifi devices
  void _connectWiFiDevice(BuildContext context, String deviceName) async {
    final passwordController = TextEditingController();
    final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
    final devices = deviceProvider.wifiDevices;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Wi-Fi Password"),
          content: TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle:
                  TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final password = passwordController.text;

                // Pass the devices list to Wi-Fi service along with SSID and password
                final isConnected = await _wifiService.connectToWifi(
                    deviceName, password, devices);

                Navigator.pop(context); // Close the dialog

                if (isConnected) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Connected to '$deviceName'"),
                    ),
                  );
                  // Navigate to data visualization screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DataVisualisationScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("Failed to connect to '$deviceName'")),
                  );
                }
              },
              child: Text(
                'Connect',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ],
        );
      },
    );
  }
}
