import 'package:flutter/material.dart';
import 'package:coffeemush/widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: CMDrawer(),
      body: Center(
        child: Text('Welcome to the CoffeeMush!'),
      ),
    );
  }
}