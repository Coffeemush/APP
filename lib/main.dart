import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/auth_screen.dart';
import 'pages/home_screen.dart';
import 'pages/profile_screen.dart';
import 'pages/scanning_screen.dart';
import 'pages/settings_screen.dart';
import 'pages/information_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');

  runApp(MyApp(initialRoute: token == null ? '/auth' : '/information'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CoffeeMush',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Coffee',
        primaryColor: const Color.fromARGB(255, 117, 67, 49),
        scaffoldBackgroundColor: Color.fromARGB(255,220,200,172)
      ),
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/auth', page: () => AuthScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: '/scan', page: () => QRScanningScreen()),
        GetPage(name: '/settings', page: () => SettingsScreen()),
        GetPage(name: '/information', page: () => InformationScreen()),
        // Add other routes here
      ],
    );
  }
}