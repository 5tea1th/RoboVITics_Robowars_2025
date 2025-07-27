import 'package:flutter/material.dart';

class RightSemiCircle extends StatelessWidget {
   BorderRadius kdirection;

  RightSemiCircle({
    required this.kdirection,
});

  late var kBottomLeftCircle = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0x73000000), Color(0x73A74FEF)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
      borderRadius: kdirection,
    );


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,

      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color(0xFF6D37C4), width: 2.0),
      ),
      child: Stack(
        children: [
          // Quarter circle in top-right corner
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 100,  // adjust size
              height: 200,
              decoration: kBottomLeftCircle,
            ),
          ),
        ],
      ),
    );
  }
}