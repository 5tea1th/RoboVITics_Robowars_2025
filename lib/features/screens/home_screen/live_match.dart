import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveMatch extends StatefulWidget {
  const LiveMatch({super.key});

  @override
  State<LiveMatch> createState() => _LiveMatchState();
}

class _LiveMatchState extends State<LiveMatch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          border: GradientBoxBorder(
            width: 3,
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(250, 96, 60, 147),
                Color.fromARGB(255, 93, 62, 137),
                Color.fromRGBO(119, 95, 154, 0.98),
                Color.fromARGB(255, 161, 146, 186),
              ],
            ),
          ),
          borderRadius: BorderRadius.circular(10),
          //color: Colors.grey[900],
        ),
        height: 220,
        width: 335,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(29, 0, 29, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Live Match',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      letterSpacing: 1.75,
                    ),
                  ),
                  SizedBox(
                    height: 24, // Fixed height for the badge container
                    child: Stack(
                      clipBehavior: Clip.none, // Allows elements to overflow
                      children: [
                        // Red background container
                        Container(
                          width: 50,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 235, 94, 87),
                                Color.fromARGB(255, 237, 109, 104),
                                Color.fromARGB(255, 237, 120, 115),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        // LIVE badge positioned absolutely
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  margin: const EdgeInsets.only(right: 4),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Text(
                                  'LIVE',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    letterSpacing: 0.5,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                  height: 115,
                  width: 315,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Expanded(
                  child: Text(
                    'Team Xenon Vs Team TerrorBulls',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
