import 'package:flutter/material.dart';

class VSIndicator extends StatelessWidget {
  const VSIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 45,
      width: 30,
      child: const Text(
        'V/s',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
