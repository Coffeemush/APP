import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coffeemush/controllers/information_controller.dart';
import 'package:coffeemush/utils/device_data.dart';
import 'package:coffeemush/widgets/data_device_screen.dart';
import 'package:coffeemush/widgets/plot_widget.dart';
import 'package:coffeemush/utils/device_name.dart';

class DeviceWidget extends StatelessWidget {
  final DeviceName device;

  DeviceWidget({required this.device});

  @override
  Widget build(BuildContext context) {
    final InformationController informationController = Get.find();
    final TextEditingController nameController = TextEditingController(text: device.name);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Device Name'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              informationController.updateDeviceName(device.id, nameController.text);
            },
            child: Text('Save Name'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              DeviceData deviceData = await informationController.fetchDeviceData(device.id);
              Get.to(() => DeviceDataScreen(deviceData: deviceData));
            },
            child: Text('Fetch Device Data'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.to(() => PlotWidget(deviceName: device.id, sensorType: 'temperature'));
            },
            child: Text('Plot Temperature History'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => PlotWidget(deviceName: device.id, sensorType: 'light'));
            },
            child: Text('Plot Light History'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => PlotWidget(deviceName: device.id, sensorType: 'humidity'));
            },
            child: Text('Plot Humidity History'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => PlotWidget(deviceName: device.id, sensorType: 'picture'));
            },
            child: Text('Get instant picture'),
          )
        ],
      ),
    );
  }
}