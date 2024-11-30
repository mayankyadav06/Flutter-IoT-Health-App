import 'package:flutter/material.dart';

class DeviceItem extends StatelessWidget {
  final String deviceName;
  final String? connectionType;
  final VoidCallback onConnect;

  const DeviceItem({
    Key? key,
    required this.deviceName,
    required this.connectionType,
    required this.onConnect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black87,
      color: Colors.grey[300],
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: connectionType == "Wi-Fi"
            ? Icon(
                Icons.wifi,
                size: 40,
                color: Colors.black,
              )
            : Icon(
                Icons.bluetooth,
                size: 40,
                color: Colors.black,
              ),
        title: Text(
          deviceName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "Connection Type: $connectionType",
          style: TextStyle(color: Colors.black),
        ),
        trailing: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.black)),
          onPressed: onConnect,
          child: const Text(
            "Connect",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
