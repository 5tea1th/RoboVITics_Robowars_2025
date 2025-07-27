import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class LeaderboardTab extends StatefulWidget {
  final VoidCallback onTabClicked;
  const LeaderboardTab({super.key, required this.onTabClicked});

  @override
  State<LeaderboardTab> createState() => _LeaderboardTabState();
}

class _LeaderboardTabState extends State<LeaderboardTab> {
  List<String> names = <String>[
    'Arnav Srivastava',
    'Arnav Srivastava',
    'Arnav Srivastava',
    'Arnav Srivastava',
    'Arnav Srivastava',
    'Arnav Srivastava',
  ];
  List<int> points = <int>[100, 100, 100, 100, 100, 100, 100];
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: widget.onTabClicked,
            child: SizedBox(
              height: 300,
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: names.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 40, // Increased height for better spacing
                      decoration: BoxDecoration(
                        border: GradientBoxBorder(
                          width: 2,
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 93, 62, 137),
                              Color.fromRGBO(119, 95, 154, 0.98),
                              Color.fromARGB(255, 161, 146, 186),
                            ],
                          ),
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Container(
                                  height: 24,
                                  width: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 140, 45, 225),
                                  ),
                                ),
                                Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12, // Increased font size
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                names[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14, // Increased font size
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Text(
                              '${points[index]} pts',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14, // Increased font size
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Divider(
            color: Color.fromARGB(255, 140, 45, 225),
            thickness: 2,
            height: 4.0,
            indent: 8,
            endIndent: 8,
          ),
          Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text(
              'Your Rank',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: 40, // Increased height for better spacing
              decoration: BoxDecoration(
                border: GradientBoxBorder(
                  width: 2,
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 93, 62, 137),
                      Color.fromRGBO(119, 95, 154, 0.98),
                      Color.fromARGB(255, 161, 146, 186),
                    ],
                  ),
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 140, 45, 225),
                          ),
                        ),
                        Text(
                          '10',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Anirban Haldar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14, // Increased font size
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      '-50 pts',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
