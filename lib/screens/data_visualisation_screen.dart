import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iot_health_app/widgets/custom_bottom_navbar.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/current_screen_provider.dart';
import '../providers/sensor_data_provider.dart';

class DataVisualisationScreen extends StatefulWidget {
  const DataVisualisationScreen({super.key});

  @override
  State<DataVisualisationScreen> createState() =>
      _DataVisualisationScreenState();
}

class _DataVisualisationScreenState extends State<DataVisualisationScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchAndScheduleData();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Fetching sensor data periodically
  void _fetchAndScheduleData() {
    final sensorDataProvider =
        Provider.of<SensorDataProvider>(context, listen: false);
    sensorDataProvider.fetchSensorData(); // Fetch initial data
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      sensorDataProvider.fetchSensorData(); // Fetch data every 10 seconds
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Visualisation",
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey[400],
      ),
      bottomNavigationBar:
          CustomBottomNavbar(), // Custom Navigation Bar using Gnav
      body: Consumer<SensorDataProvider>(
        builder: (context, sensorDataProvider, child) {
          if (sensorDataProvider.sensorData == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (Provider.of<CurrentScreenProvider>(context).currentScreen == 0) {
            // Data View with Icons
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.grey[300],
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.thermostat_outlined,
                              size: 50, color: Colors.red),
                          const SizedBox(width: 16),
                          Text(
                            "Temperature: ${sensorDataProvider.sensorData!.temperature} °C",
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: Colors.grey[300],
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.favorite,
                              size: 50, color: Colors.pinkAccent),
                          const SizedBox(width: 16),
                          Text(
                            "Heart Rate: ${sensorDataProvider.sensorData!.heartRate} BPM",
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Chart View
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.2),
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.2),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, interval: 10),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, interval: 1),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.teal, width: 1),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: sensorDataProvider.temperatureData,
                      isCurved: true,
                      barWidth: 4,
                      color: Colors.teal, // Line color
                      belowBarData: BarAreaData(
                          show: true, color: Colors.teal.withOpacity(0.3)),
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
