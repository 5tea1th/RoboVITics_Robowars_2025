import 'package:flutter/material.dart';

class TeamWidget extends StatelessWidget {
  final String teamName;
  final bool isExpanded;

  const TeamWidget({
    super.key,
    required this.teamName,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 95,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(teamName, style: TextStyle(color: Colors.white)),
    );
  }
}
