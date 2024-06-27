import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coffeemush/utils/api_endpoints.dart';
import 'package:coffeemush/utils/device_data.dart';
import 'package:flutter/material.dart';
import 'package:coffeemush/utils/device_name.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class InformationController extends GetxController {
  var devices = <DeviceName>[].obs;
  WebSocketChannel? channel;

  @override
  void onInit() {
    print('aaaaaa');
    super.onInit();
    fetchDevices();
  }


  Future<http.Response> buildRequest(extraHeaders) async {
    try {
      final SharedPreferences? prefs = await _prefs;
      String? token = prefs?.getString('token');
      var headers = {'Content-Type': 'application/json', "token": token ?? ''};
      headers.addAll(extraHeaders);
      var url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.connectionEndpoint);
      http.Response response = await http.get(url, headers: headers);
      return response;
    } catch (e) {
      print('Exception: $e');
      return http.Response('Error: $e', 500);
    }
  }

  void updateDeviceName(String id, String newName) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.updateDeviceName);
      final SharedPreferences? prefs = await _prefs;
      String? token = prefs?.getString('token');
      Map<String, String> body = {
        "token": token ?? '',
        "id": id,
        "name": newName
      };
      await http.post(url, body: jsonEncode(body), headers: headers);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update device name');
    }
  }

  void fetchDevices() async {
    print("fetching devices!!!");
    try {
      var extra = <String, String>{};
      var response = await buildRequest(extra);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        devices.value = List<DeviceName>.from(data['devices'].map((device) => DeviceName.fromJson(device)));
        //devices.value = List<DeviceName>.from(data['devices']);
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch device data');
    }
  }

  Future<DeviceData> fetchDeviceData(String id) async {
    try {
      var extra = {
        'id': id
      };
      var response = await buildRequest(extra);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('alerta');
        print(data['device']);
        DeviceData deviceData = DeviceData.fromJson(data['device']);
        return deviceData;
      } else {
        print('Error: ${response.body}');
        return DeviceData(humidity: 0, id: "None", light: 0, name: 'None', temperature: 0, waterEmpty: false);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch device data');
      return DeviceData(humidity: 0, id: "None", light: 0, name: 'None', temperature: 0, waterEmpty: false);
    }
  }

  Future<Image?> fetchHistoryData(String id, String sensorType) async {
    try {
      var extra = {
        'id': id,
        'sensor': sensorType
      };
      var response = await buildRequest(extra);
      if (response.statusCode == 200) {
        print('Response body (first 100 bytes): ${response.bodyBytes.sublist(0, 50)}');
        return Image.memory(response.bodyBytes);
      } else {
        throw Exception('Failed to load plot');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to fetch history data');
      return null;
    }
  }
}