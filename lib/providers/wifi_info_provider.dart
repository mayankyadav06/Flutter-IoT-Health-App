import 'package:flutter/material.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

class WiFiInfoProvider with ChangeNotifier {
  String? _wifiName;
  String? _wifiBSSID;
  String? _wifiIP;
  bool _isLoading = true;

  String? get wifiName => _wifiName;
  String? get wifiBSSID => _wifiBSSID;
  String? get wifiIP => _wifiIP;
  bool get isLoading => _isLoading;

  Future<void> fetchCurrentWifiInfo() async {
    try {
      _isLoading = true;
      notifyListeners(); // Notify listeners to update UI

      final wifiName = await WifiInfo().getWifiName(); // Wi-Fi SSID
      final wifiBSSID = await WifiInfo().getWifiBSSID(); // Wi-Fi BSSID
      final wifiIP = await WifiInfo().getWifiIP(); // Device IP address

      _wifiName = wifiName ?? "Unknown Wi-Fi";
      _wifiBSSID = wifiBSSID ?? "Unknown BSSID";
      _wifiIP = wifiIP ?? "Unknown IP";
    } catch (e) {
      _wifiName = "Unable to fetch Wi-Fi info";
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners after the loading state is complete
    }
  }
}
