import 'package:coffeemush/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> login() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
        ApiEndpoints.baseUrl + ApiEndpoints.loginEndpoint
      );
      Map body = {
        "user_email": emailController.text,
        "user_password": passwordController.text
      };
      http.Response response = 
        await http.post(url, body: jsonEncode(body), headers: headers);
      if(response.statusCode == 200) {
        print(jsonDecode(response.body));
        if(jsonDecode(response.body)['valid'] == true){
          var token = jsonDecode(response.body)['token'];
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', token);
          emailController.clear();
          passwordController.clear();      
          Get.offAllNamed('/home');
        }else{
          throw jsonDecode(response.body)["error"] ?? "There is been an error.";
        }
      }else{
        throw jsonDecode(response.body)["error"] ?? "There is been an error.";
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
        });
    }
  }
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}