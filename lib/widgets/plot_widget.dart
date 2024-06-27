import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:coffeemush/controllers/information_controller.dart';
import 'package:get/get.dart';

class PlotWidget extends StatelessWidget {
  final String deviceName;
  final String sensorType;

  PlotWidget({required this.deviceName, required this.sensorType});

  @override
  Widget build(BuildContext context) {
    final InformationController informationController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('History Data'),
      ),
      body: FutureBuilder<Image?>(
        future: informationController.fetchHistoryData(deviceName, sensorType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            return Center(child: snapshot.data!);
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}