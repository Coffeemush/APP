import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CMDrawer extends StatelessWidget {
  const CMDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Color.fromARGB(122, 134, 12, 22),
              ),
            ),
            ListTile(
              title: Text('Device information'),
              onTap: () {
                print('Navigating to scan');
                Get.toNamed('/information');
              },
            ),
            ListTile(
              title: Text('Connect device'),
              onTap: () {
                print('Navigating to scan');
                Get.toNamed('/scan');
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                print('Navigating to Profile');
                Get.toNamed('/profile');
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                print('Navigating to Settings');
                Get.toNamed('/settings');
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () async {
                print('Logging out');
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('token');
                Get.offAllNamed('/auth');
              },
            ),
          ],
        ),
      );
  }
}