import 'package:flutter/material.dart';
import 'package:coffeemush/utils/device_data.dart';

class DeviceDataScreen extends StatelessWidget {
  final DeviceData deviceData;

  DeviceDataScreen({required this.deviceData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${deviceData.name} Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDataCard(
              context,
              icon: Icons.water_drop,
              label: 'Humidity',
              value: '${deviceData.humidity.toStringAsFixed(2)}%',
            ),
            SizedBox(height: 10),
            _buildDataCard(
              context,
              icon: Icons.wb_sunny,
              label: 'Light',
              value: '${deviceData.light.toStringAsFixed(2)} lx',
            ),
            SizedBox(height: 10),
            _buildDataCard(
              context,
              icon: Icons.thermostat,
              label: 'Temperature',
              value: '${deviceData.temperature.toStringAsFixed(2)} °C',
            ),
            SizedBox(height: 10),
            _buildDataCard(
              context,
              icon: Icons.water,
              label: 'Water Empty',
              value: deviceData.waterEmpty ? "Yes" : "No",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCard(BuildContext context, {required IconData icon, required String label, required String value}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Theme.of(context).primaryColor),
        title: Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}