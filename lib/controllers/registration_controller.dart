import 'package:coffeemush/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> register() async {
    try {
      if(passwordController.text != confirmPasswordController.text){
        throw "Password does not match confirmation!";
      }
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
        ApiEndpoints.baseUrl + ApiEndpoints.loginEndpoint
      );
      Map body = {
        "user_surname": surnameController.text,
        "user_given_name": nameController.text,
        "user_email": emailController.text,
        "user_phone": phoneController.text,
        "user_city": cityController.text,
        "user_address": addressController.text,
        "user_password": passwordController.text
      };
      http.Response response = 
        await http.put(url, body: jsonEncode(body), headers: headers);
      if(response.statusCode == 200) {
        var token = jsonDecode(response.body)['token'];
        final SharedPreferences? prefs = await _prefs;
        await prefs?.setString('token', token);
        surnameController.clear();
        nameController.clear();
        emailController.clear();
        phoneController.clear();
        cityController.clear();
        addressController.clear();
        passwordController.clear();
        confirmPasswordController.clear(); // Clear the confirm password controller
        Get.offAllNamed('/home');
      }else{
        print(jsonDecode(response.body));
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
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose(); // Dispose the confirm password controller
    super.onClose();
  }
}