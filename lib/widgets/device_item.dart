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
      color: Theme.of(context).colorScheme.surface,
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: connectionType == "Wi-Fi"
            ? Icon(
                Icons.wifi,
                size: 40,
              )
            : Icon(
                Icons.bluetooth,
                size: 40,
              ),
        title: Text(
          deviceName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "Connection Type: $connectionType",
        ),
        trailing: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
          ),
          onPressed: onConnect,
          child: Text(
            "Connect",
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      ),
    );
  }
}
