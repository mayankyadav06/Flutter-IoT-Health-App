// Data model for Sensor data to fetch from backend
class SensorData {
  final double? temperature;
  final int? heartRate;

  SensorData({required this.temperature, required this.heartRate});

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      temperature: json['temperature']?.toDouble(),
      heartRate: json['heartRate'] as int?,
    );
  }
}
