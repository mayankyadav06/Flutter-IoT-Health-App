import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sensor_data.dart';

class SensorDataProvider extends ChangeNotifier {
  SensorData? _sensorData;
  List<FlSpot> _temperatureData = [];

  SensorData? get sensorData => _sensorData;
  List<FlSpot> get temperatureData => _temperatureData;

  final String apiUrl = 'http://192.168.43.95:5000/api/sensor_data'; // API URL

  Future<void> fetchSensorData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        debugPrint('Received data: $data');

        _sensorData = SensorData.fromJson(data);
        print("SENSOR DATA ${_sensorData!.heartRate}");

        // Update temperature data for chart
        _temperatureData.add(FlSpot(_temperatureData.length.toDouble(),
            _sensorData!.temperature ?? 0.0));

        notifyListeners(); // Notify listeners of data change
      } else {
        throw Exception('Failed to fetch sensor data');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }
}
