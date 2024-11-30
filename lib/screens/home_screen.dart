import 'package:flutter/material.dart';
import 'package:iot_health_app/screens/device_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:iot_health_app/providers/device_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Text editing controller
  late TextEditingController _deviceNameController;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the deviceName from the provider
    final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
    _deviceNameController =
        TextEditingController(text: deviceProvider.deviceName);
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed
    _deviceNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Device provider consumer
        child: Consumer<DeviceProvider>(
          builder: (context, deviceProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add New Device",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 16),
                // Input field for device name
                TextField(
                  controller: _deviceNameController,
                  decoration: InputDecoration(
                    labelText: "Device Name",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    prefixIcon: Icon(
                      Icons.device_hub,
                      color: Colors.black, // Icon color red
                    ),
                  ),
                  onChanged: (value) {
                    deviceProvider.setDeviceName(value);
                  },
                ),
                const SizedBox(height: 16),
                // Dropdown menu for connection type
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.grey[300],
                  value: deviceProvider.selectedConnectionType,
                  decoration: InputDecoration(
                    iconColor: Colors.black,
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: "Connection Type",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  // Items for dropdown menu
                  items: [
                    {'type': 'Bluetooth', 'icon': Icons.bluetooth},
                    {'type': 'Wi-Fi', 'icon': Icons.wifi},
                  ].map((connectionType) {
                    return DropdownMenuItem<String>(
                      value: connectionType['type'] as String,
                      child: Row(
                        children: [
                          Icon(
                            connectionType['icon'] as IconData,
                            size: 20,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            connectionType['type'] as String,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    deviceProvider.setConnectionType(value);
                  },
                ),
                const SizedBox(height: 24),
                // Submit button
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.black),
                    ),
                    onPressed: () {
                      final deviceName = deviceProvider.deviceName.trim();
                      final connectionType =
                          deviceProvider.selectedConnectionType;
                      if (deviceName.isEmpty ||
                          deviceProvider.selectedConnectionType == null) {
                        // Showing snackbar as gentle warning to correctly fill form
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Please enter device name and select a connection type"),
                          ),
                        );
                        return;
                      }
                      // Navigate to the device list screen
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DevicesScreen(
                            connectionType: connectionType as String,
                          ),
                        ),
                      );

                      // Add the device to the list
                      deviceProvider.addDevice();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text("Device '$deviceName' added successfully"),
                        ),
                      );

                      // Clear input fields after adding
                      _deviceNameController.clear();
                      deviceProvider.clearDevice();
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
