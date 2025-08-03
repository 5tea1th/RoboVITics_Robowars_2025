import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:robowars_app/features/screens/home_screen/quick_stats.dart';

import 'key_contenders.dart';
import 'live_match.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Widget logo = SvgPicture.asset(
    'assets/images/robovitics logo.svg',
    height: 40,
    width: 40,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      appBar:AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: logo,
        ),
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: 'Trajan Pro',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Icon(
              Icons.account_circle_outlined,
              color: Color(0xFF9C49E2),
              size: 35,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
       child: Column(children: [
         Container(
           height: 4,
           margin: const EdgeInsets.symmetric(horizontal: 30),
           decoration: const BoxDecoration(
             gradient: LinearGradient(
               begin: Alignment.centerLeft,
               end: Alignment.centerRight,
               colors: [
                 Colors.transparent,
                 Color(0xFFB84BFF),
                 Colors.transparent,
               ],
               stops: [0, 0.5, 1.0],
             ),
           ),
         ),
         Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      //GalleryCarousel(),
                      SizedBox(height: 20),
                      //YouTubeLiveEmbed(),
                      SizedBox(height: 20),
                      LiveMatch(),
                      SizedBox(height: 20),
                      KeyContenders(
                        contenders: [
                          Contender(
                            name: "Raven (60 kg)",
                            team: "Team Orcus",
                            result: "Wins",
                          ),
                          Contender(
                            name: "Vulcan (15 kg)",
                            team: "Team Orcus",
                            result: "Wins",
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      QuickStats(
                        stats: {
                          "Matches": "6",
                          "Wins": "4",
                          "Losses": "2",
                          "KOs": "3",
                        },
                      ),
                      SizedBox(height: kBottomNavigationBarHeight+10),
                    ],
                  ),
                ),
      ]),
      ),
    );
  }
}
