import 'package:datepicker/constants.dart';
import 'package:datepicker/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColorLight,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "Select Date",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 768) {
          // Mobile
          return HomeScreen();
        } else {
          return SizedBox(
            width: size.width * 0.50,
            child: HomeScreen(),
          );
        }
      }),
    );
  }
}
