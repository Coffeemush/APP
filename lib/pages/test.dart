import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CoffeeMush'),
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
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white
            ),
          )
        ]
      )
    );
  }
}