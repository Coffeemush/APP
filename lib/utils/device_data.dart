class DeviceData {
  final double humidity;
  final String id;
  final double light;
  final String name;
  final double temperature;
  final bool waterEmpty;

  DeviceData({
    required this.humidity,
    required this.id,
    required this.light,
    required this.name,
    required this.temperature,
    required this.waterEmpty,
  });

  factory DeviceData.fromJson(Map<String, dynamic> json) {
    return DeviceData(
      humidity: json['humidity'],
      id: json['id'],
      light: json['light'],
      name: json['name'],
      temperature: json['temperature'],
      waterEmpty: json['water_empty'],
    );
  }
}