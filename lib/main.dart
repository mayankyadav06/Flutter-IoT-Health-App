import 'package:flutter/material.dart';
import 'package:iot_health_app/providers/loading_provider.dart';
import 'package:iot_health_app/providers/sensor_data_provider.dart';
import 'package:iot_health_app/providers/wifi_info_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:iot_health_app/providers/current_screen_provider.dart';
import 'package:iot_health_app/providers/device_provider.dart';
import 'package:iot_health_app/screens/home_screen.dart';
import 'package:iot_health_app/widgets/custom_bottom_navbar.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HealthApp());
}

class HealthApp extends StatelessWidget {
  const HealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrentScreenProvider()),
        ChangeNotifierProvider(create: (context) => DeviceProvider()),
        ChangeNotifierProvider(create: (context) => WiFiInfoProvider()),
        ChangeNotifierProvider(create: (context) => LoadingProvider()),
        ChangeNotifierProvider(create: (context) => SensorDataProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const PermissionHandlerScreen(),
      ),
    );
  }
}

class PermissionHandlerScreen extends StatefulWidget {
  const PermissionHandlerScreen({super.key});

  @override
  State<PermissionHandlerScreen> createState() =>
      _PermissionHandlerScreenState();
}

class _PermissionHandlerScreenState extends State<PermissionHandlerScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializePermissions();
  }

  Future<void> _initializePermissions() async {
    // Request permissions
    final bluetoothPermission = Permission.bluetooth;
    final bluetoothScanPermission = Permission.bluetoothScan;
    final bluetoothConnectPermission = Permission.bluetoothConnect;
    final locationPermission = Permission.location;

    // Check if permissions are already granted
    var bluetoothStatus = await bluetoothPermission.status;
    var locationStatus = await locationPermission.status;
    var bluetoothScanStatus = await bluetoothScanPermission.status;
    var bluetoothConnectStatus = await bluetoothConnectPermission.status;

    print('Bluetooth Status: $bluetoothStatus');
    print('Bluetooth Scan Status: $bluetoothScanStatus');
    print('Bluetooth Connect Status: $bluetoothConnectStatus');
    print('Location Status: $locationStatus');

    // Request permissions if not granted
    if (bluetoothStatus.isDenied ||
        locationStatus.isDenied ||
        bluetoothScanStatus.isDenied ||
        bluetoothConnectStatus.isDenied) {
      await [
        bluetoothPermission,
        bluetoothScanPermission,
        bluetoothConnectPermission,
        locationPermission,
      ].request();
    }

    if (bluetoothStatus.isPermanentlyDenied ||
        locationStatus.isPermanentlyDenied) {
      openAppSettings(); // Opens the app settings page.
    }

    // Navigate to the main app screen after permissions are handled
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : const MainScreen();
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: const Text(
          'IoT Health App',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: const HomeScreen(), // Navigating to Home Screen
    );
  }
}
