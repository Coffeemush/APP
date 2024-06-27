import 'package:coffeemush/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> set() async {
    try {
      if(passwordController.text != confirmPasswordController.text){
        throw "Password does not match confirmation!";
      }
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.userEndpoint);
      final SharedPreferences? prefs = await _prefs;
      String? token = prefs?.getString('token');
      Map<String, String> body = {"token": token ?? ''};
      if (nameController.text.isNotEmpty) body["user_given_name"] = nameController.text.trim();
      if (surnameController.text.isNotEmpty) body["user_surname"] = surnameController.text.trim();
      if (emailController.text.isNotEmpty) body["user_email"] = emailController.text.trim();
      if (phoneController.text.isNotEmpty) body["user_phone"] = phoneController.text.trim();
      if (cityController.text.isNotEmpty) body["user_city"] = cityController.text.trim();
      if (addressController.text.isNotEmpty) body["user_address"] = addressController.text.trim();
      if (passwordController.text.isNotEmpty) body["user_password"] = passwordController.text.trim();
      http.Response response = await http.put(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var token = jsonDecode(response.body)['token'];
        await prefs?.setString('token', token);
      } else {
        print(jsonDecode(response.body));
        throw jsonDecode(response.body)["error"] ?? "There has been an error.";
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

  Future<void> getUserInfo() async {
    try {
      final SharedPreferences? prefs = await _prefs;
      String? token = prefs?.getString('token');
      var headers = {'Content-Type': 'application/json', "token": token ?? ''};
      var url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.userEndpoint);
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        if(userData['user_surname'] == null){
          surnameController.text = '';
        }else{
          surnameController.text = userData['user_surname'];
        }
        nameController.text = userData['user_given_name'];
        emailController.text = userData['user_email'];
        phoneController.text = userData['user_phone'];
        cityController.text = userData['user_city'];
        addressController.text = userData['user_address'];
      } else {
        print(jsonDecode(response.body));
        throw jsonDecode(response.body)["error"] ?? "There has been an error.";
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

  @override
  void onClose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}