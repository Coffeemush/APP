import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coffeemush/controllers/login_controller.dart';
import 'package:coffeemush/controllers/registration_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final LoginController loginController = Get.put(LoginController());
  final RegistrationController registrationController = Get.put(RegistrationController());
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Login' : 'Register'),
        centerTitle: true,
        leading: Container(
          margin: EdgeInsets.all(10),
          child: SvgPicture.asset(
            'assets/icons/logo.svg',
            height: 30,
            width: 30),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 199, 184, 184),
            borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: isLogin ? loginController.emailController : registrationController.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: isLogin ? loginController.passwordController : registrationController.passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              if (!isLogin) ...[
                SizedBox(height: 16),
                TextField(
                  controller: registrationController.confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: registrationController.nameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: registrationController.surnameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: registrationController.phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: registrationController.cityController,
                  decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: registrationController.addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (isLogin) {
                    loginController.login();
                  } else {
                    registrationController.register();
                  }
                },
                child: Text(isLogin ? 'Login' : 'Register'),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Text(isLogin ? 'Don\'t have an account? Register' : 'Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}