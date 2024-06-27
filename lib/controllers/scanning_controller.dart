import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:coffeemush/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coffeemush/utils/defaults.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class ScanningController extends GetxController {
  Future<void> connect(String qrContent) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.connectionEndpoint);
      final SharedPreferences? prefs = await _prefs;
      String? token = prefs?.getString('token');
      Map<String, String> body = {
        "token": token ?? '',
        "id": qrContent,
        "options": jsonEncode(Defaults.connection_options)
      };
      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        Get.offAllNamed('/home');
        showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Device connected succesfully!'),
              contentPadding: EdgeInsets.all(20),
              children: [Text('Now you have full acces to your device.')],
            );
          }
        );
      } else {
        Get.back();
        showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Could not connect device.'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(jsonDecode(response.body)['error'])],
            );
          }
        );

      }
    } catch (e) {
      Get.back();
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: Text('Error'),
            contentPadding: EdgeInsets.all(20),
            children: [Text(e.toString())],
          );
        },
      );
    }
  }
}