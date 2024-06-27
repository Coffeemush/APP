import 'package:flutter/material.dart';
import 'package:coffeemush/widgets/drawer.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: CMDrawer(),
      body: Center(
        child: Text('Who do you think you are? Roberto decides all the settings'),
      ),
    );
  }
}