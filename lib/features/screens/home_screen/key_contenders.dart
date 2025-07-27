import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class Contender {
  final String name;
  final String team;
  final String result;

  Contender({required this.name, required this.team, required this.result});
}

class KeyContenders extends StatelessWidget {
  final List<Contender> contenders;

  const KeyContenders({super.key, required this.contenders});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(29, 16, 29, 16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: GradientBoxBorder(
          width: 3,
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 93, 62, 137),
              Color.fromRGBO(119, 95, 154, 0.98),
              Color.fromARGB(255, 161, 146, 186),
            ],
          ),
        ),
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Contenders',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: contenders
                .map(
                  (contender) => _ContenderRow(
                    name: contender.name,
                    team: contender.team,
                    result: contender.result,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ContenderRow extends StatelessWidget {
  final String name;
  final String team;
  final String result;

  const _ContenderRow({
    required this.name,
    required this.team,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                team,
                style: GoogleFonts.montserrat(color: Colors.grey[400]),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              result,
              style: GoogleFonts.montserrat(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
