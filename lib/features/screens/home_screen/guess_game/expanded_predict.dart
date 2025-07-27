import 'package:flutter/material.dart';

class ExpandablePrediction extends StatefulWidget {
  final Widget choice;
  const ExpandablePrediction({super.key, required this.choice});

  @override
  State<ExpandablePrediction> createState() => _ExpandablePredictionState();
}

class _ExpandablePredictionState extends State<ExpandablePrediction> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Color.fromARGB(255, 140, 45, 225),
                thickness: 2,
                height: 4.0,
                indent: 8,
                endIndent: 8,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Your Prediction',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.25,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 16),
              alignment: Alignment.centerLeft,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    255,
                    137,
                    44,
                    225,
                  ).withOpacity(0.2), // 20% opacity purple
                  borderRadius: BorderRadius.circular(
                    8,
                  ), // Optional rounded corners
                ),
                child: widget.choice,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
