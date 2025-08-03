import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  String selectedTab = 'Upcoming';
  List<Map<String, dynamic>> scheduleData = [];

  @override
  void initState() {
    super.initState();
    fetchSchedule();
  }

  void fetchSchedule() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('schedule').get();
      final data = snapshot.docs.map((doc) => doc.data()).toList();
      setState(() {
        scheduleData = data;
      });
    } catch (e) {
      print('Error loading schedule: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  height: 40,
                  width: 40,
                ),
              ),
              centerTitle: true,
              title: const Text(
                "Schedule",
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
          ],
        ),
      ),

      body: Column(
        children: [
          // Tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => setState(() => selectedTab = 'Upcoming'),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: selectedTab == 'Upcoming' ? LinearGradient(colors: [Colors.purple, Color(0xFFB84BFF)]) :  LinearGradient(colors: [ Color(212121),Color(212121)]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Upcoming',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => selectedTab = 'Completed'),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: selectedTab == 'Completed' ? LinearGradient(colors: [Colors.purple, Color(0xFFB84BFF)]) : LinearGradient(colors: [Color(212121), Color(212121)]),

                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Completed',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),


          //Upcoming

          Expanded(

              child: selectedTab == 'Upcoming' ?
              ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: scheduleData.length,
                itemBuilder: (context, index) {
                  final match = scheduleData[index];
                  final team1 = match['team1'] ?? '';
                  final team2 = match['team2'] ?? '';
                  final bot1 = match['bot1'] ?? '';
                  final bot2 = match['bot2'] ?? '';
                  final category = match['category'] ?? '';
                  final startTime = match['startTime'] ?? '';
                  final winner = match['winner'] ?? '';
                  return Container(
                    height: 184,
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.purpleAccent),
                    ),
                    child: Stack(
                      children: [
                        // 🔵 Decorative Quarter Circle at Top-Right
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 130,
                            height: 200,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0x73000000), Color(0x73A74FEF)],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(150),
                              ),
                            ),
                          ),
                        ),
                        // 📝 Main Card Content
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top Row
                            Container(
                              padding: const EdgeInsets.only(top:15,left:15,right: 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "$team1\n($bot1)",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        "Starts at",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "$startTime",
                                        style: const TextStyle(
                                          color: Color(0xFFB84BFF),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            // V/S Stylized
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: RichText(
                                text: const TextSpan(
                                  text: 'V',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '/',
                                      style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFB84BFF),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'S',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 13),
                            // Bottom Row
                            Container(
                              padding: const EdgeInsets.only(bottom:15,left:15,right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "$team2\n($bot2)",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 4,
                                          offset: const Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.purpleAccent),
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xFFFFFFFF),
                                            Color(0xFF8F8F8F),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.3),
                                            blurRadius: 4,
                                            offset: const Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        "Category ($category)",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ) :








              // Completed




















              ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: scheduleData.length,
                itemBuilder: (context, index) {
                  final match = scheduleData[index];
                  final team1 = match['team1'] ?? '';
                  final team2 = match['team2'] ?? '';
                  final bot1 = match['bot1'] ?? '';
                  final bot2 = match['bot2'] ?? '';
                  final category = match['category'] ?? '';
                  final startTime = match['startTime'] ?? '';
                  final winner = match['winner'] ?? '';
                  return Container(
                    height: 184,
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.purpleAccent)),
                    child: Stack(
                      children: [
                        // 🎨 Quarter-Circle Gradient Decoration (Top-Right)
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 130,
                            height: 200,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0x73000000), Color(0x73A74FEF)],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(150),
                              ),
                            ),
                          ),
                        ),
                        // 🧱 Main Content
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top Row
                            Container(
                              padding: const EdgeInsets.only(top:15,left:15,right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "$team1\n($bot1)",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: const [
                                      Text(
                                        "WINNERS",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Monsterrat',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            // V/S with MATCH info
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Left: V/S
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child:  RichText(
                                    text: const TextSpan(
                                      text: 'V',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '/',
                                          style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFB84BFF),
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'S',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Right: MATCH (e.g., Match 1)
                                Transform.translate(
                                  offset: const Offset(0, -20),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Text(
                                      winner,
                                      style: const TextStyle(
                                        color: Color(0xFFBA9BE2),
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Bottom Row
                            Container(
                              padding: const EdgeInsets.only(bottom:15,left:15,right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "$team2\n($bot2)",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 4,
                                          offset: const Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.purpleAccent),
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xFFFFFFFF),
                                            Color(0xFF8F8F8F),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.3),
                                            blurRadius: 4,
                                            offset: const Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        "Category ($category)",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
          ),
        ],
      ),
    );
  }
}