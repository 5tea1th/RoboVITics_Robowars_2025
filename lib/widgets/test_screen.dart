import 'package:flutter/material.dart';
import 'package:robowars_app/home_page/widgets/rightSemiCircle.dart';

class TestingScreen extends StatelessWidget {
  static const String id = 'testing_screen';
  const TestingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RightSemiCircle(kdirection: BorderRadius.only(bottomLeft: Radius.circular(150))),
          RightSemiCircle(kdirection: BorderRadius.only(bottomRight: Radius.circular(150))),
          //RightSemiCircle(direction: bottomLeft),
        ],
      ),
    );
  }
}