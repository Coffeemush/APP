import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coffeemush/widgets/drawer.dart';
import 'package:coffeemush/controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: CMDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: profileController.emailController,
              decoration: InputDecoration(labelText: 'Email'),
              readOnly: true,
            ),
            SizedBox(height: 16),
            TextField(
              controller: profileController.nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: profileController.surnameController,
              decoration: InputDecoration(labelText: 'Surname'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: profileController.phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: profileController.cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: profileController.addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: profileController.passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              controller: profileController.confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                profileController.set();
              },
              child: Text('Upload Info'),
            ),
          ],
        ),
      ),
    );
  }
}