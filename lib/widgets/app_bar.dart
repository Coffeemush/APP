import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoffeemushAppBar extends StatelessWidget {
  const CoffeemushAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text('CoffeeMush'),
        centerTitle: true,
        leading: Container(
          margin: EdgeInsets.all(10),
          child: SvgPicture.asset(
            'assets/icons/logo.svg',
            height: 30,
            width: 30),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 117, 67, 49),
            borderRadius: BorderRadius.circular(10)
          ),
        ),
      );
  }
}