import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coffeemush/controllers/information_controller.dart';
import 'package:coffeemush/widgets/drawer.dart';
import 'package:coffeemush/widgets/device_widget.dart';

class InformationScreen extends StatelessWidget {
  final InformationController informationController = Get.put(InformationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (informationController.devices.isEmpty) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Devices'),
          ),
          drawer: CMDrawer(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You don\'t have any connected devices. Please add one using the QR code.'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/scan');
                  },
                  child: Text('Add Device'),
                ),
              ],
            ),
          ),
        );
      } else {
        return DefaultTabController(
          length: informationController.devices.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Devices'),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(48.0),
                child: TabBar(
                  isScrollable: true,
                  tabs: informationController.devices.map((device) {
                    return Tab(text: device.name);
                  }).toList(),
                ),
              ),
            ),
            drawer: CMDrawer(),
            body: TabBarView(
              children: informationController.devices.map((device) {
                return DeviceWidget(device: device);
              }).toList(),
            ),
          ),
        );
      }
    });
  }
}