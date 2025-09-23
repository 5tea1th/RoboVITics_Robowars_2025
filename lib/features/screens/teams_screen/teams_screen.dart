import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  bool isTeamsSelected = true;

  List<Map<String, dynamic>> teamsData = [];

  @override
  void initState() {
    super.initState();
    fetchTeamsData();
  }

  void fetchTeamsData() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('team').get();

      final data =
          snapshot.docs
              .map((doc) {
                final team = doc.data();
                if (team['name'] == null ||
                    team['image'] == null ||
                    team['description'] == null) {
                  print("Skipping doc due to missing field(s): $team");
                  return null;
                }
                return {
                  'name': team['name'] ?? 'Unnamed',
                  'image': team['image'] ?? '',
                  'description': team['description'] ?? '',
                  'matches': team['matches'] ?? 0,
                  'won': team['won'] ?? 0,
                  'lost': team['lost'] ?? 0,
                  'points': team['points'] ?? 0,
                  'bots':
                      (team['bots'] as Map<String, dynamic>? ?? {}).entries
                          .map(
                            (entry) => {
                              'name': entry.value['name'] ?? 'Unknown Bot',
                              'weight': entry.value['weight'] ?? '',
                            },
                          )
                          .toList(),
                };
              })
              .where((team) => team != null)
              .cast<Map<String, dynamic>>()
              .toList();
      //sort in descending for the table
      data.sort((a, b) => b['points'].compareTo(a['points']));

      if (mounted) {
        setState(() {
          teamsData = data;
        });
      }
    } catch (e) {
      SnackBar(content: Text('Error Fetching Teams Data'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 24),
          _buildToggle(),
          const SizedBox(height: 24),
          Expanded(child: _buildAnimatedBody()),
        ],
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                'assets/images/robovitics logo.svg',
                height: 40,
                width: 40,
              ),
            ),
            centerTitle: true,
            title: const Text(
              "Teams",
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
                child: IconButton(
                  icon: Icon(Icons.people, color: Color(0xFF9C49E2), size: 35),
                  onPressed: () {
                    Navigator.pushNamed(context, '/developers');
                  },
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
    );
  }

  Widget _buildToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 240,
          height: 44,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                alignment:
                    isTeamsSelected
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                curve: Curves.easeInOut,
                child: Container(
                  width: (240 - 6) / 2, // subtract padding, then half
                  height: 38,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF9D3AE7),
                        Color.fromARGB(255, 200, 141, 245),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap:
                          () => setState(() {
                            isTeamsSelected = true;
                          }),
                      child: Container(
                        height: 38,
                        alignment: Alignment.center,
                        child: Text(
                          'Teams',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                isTeamsSelected ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap:
                          () => setState(() {
                            isTeamsSelected = false;
                          }),
                      child: Container(
                        height: 38,
                        alignment: Alignment.center,
                        child: Text(
                          'Table',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                !isTeamsSelected ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // _toggleButton is no longer needed with sliding indicator design

  Widget _buildAnimatedBody() => AnimatedSwitcher(
    duration: const Duration(milliseconds: 300),
    child: isTeamsSelected ? _buildTeamsList() : _buildTableView(),
  );

  Widget _buildTeamsList() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: ListView.builder(
      itemCount: teamsData.length,
      itemBuilder: (context, index) {
        final team = teamsData[index];
        final bots = List<Map<String, dynamic>>.from(team['bots']);

        return GestureDetector(
          onTap: () => _showTeamPopup(context, team),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFF9D3AE7), width: 1.5),
            ),
            child: Row(
              children: [
                // Left: Team logo
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:
                      team['image'] != null &&
                              team['image'].toString().isNotEmpty
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              team['image'],
                              fit: BoxFit.cover,
                            ),
                          )
                          : null,
                ),

                const SizedBox(width: 16),

                // Right: Team name + Bots row
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Team name
                      Text(
                        team['name'] ?? 'Unnamed Team',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Bots row (horizontally scrollable)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              bots.map<Widget>((bot) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: Chip(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    label: Text(
                                      '${bot['name']} (${bot['weight']})',
                                    ),
                                    labelStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors.grey[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: const BorderSide(
                                        color: Color(0xFF9D3AE7),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  Widget _buildTableView() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        itemCount: teamsData.length,
        itemBuilder: (context, index) {
          final team = teamsData[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFF9D3AE7), width: 1.5),
            ),
            child: Row(
              children: [
                // Left rank container
                Container(
                  width: 48,
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Right main container
                Expanded(
                  child: GestureDetector(
                    onTap: () => _showTeamPopup(context, team),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Row(
                        children: [
                          // Team logo
                          Container(
                            width:
                                (screenWidth - 80) *
                                0.2, // ~1/5 of right container
                            height: (screenWidth - 80) * 0.2,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child:
                                team['image'] != null &&
                                        team['image'].toString().isNotEmpty
                                    ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        team['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                    : const SizedBox.shrink(),
                          ),
                          const SizedBox(width: 12),

                          // Stats columns
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildStatColumn(
                                  "Matches",
                                  "${team['matches']}",
                                ),
                                _buildStatColumn("Won", "${team['won']}"),
                                _buildStatColumn("Lost", "${team['lost']}"),
                                _buildStatColumn("Points", "${team['points']}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper function to build each stat column
  Widget _buildStatColumn(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF9D3AE7),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  void _showTeamPopup(BuildContext context, Map<String, dynamic> team) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Team Popup",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      pageBuilder: (context, anim1, anim2) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
          child: Center(
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF9D3AE7)),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Close button row with team name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 32),
                          Expanded(
                            child: Center(
                              child: Text(
                                team['name'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const CircleAvatar(
                              radius: 16,
                              backgroundColor: Color(0xFF9D3AE7),
                              child: Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Team logo row
                      Center(
                        child:
                            (team['image'] != null &&
                                    team['image'].toString().isNotEmpty
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    team['image'],
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height:
                                        MediaQuery.of(context).size.width * 0.4,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                : Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(
                                    Icons.image,
                                    color: Colors.white38,
                                    size: 40,
                                  ),
                                )),
                      ),
                      const SizedBox(height: 16),

                      // Bot chips row
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              team['bots'].map<Widget>((bot) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Chip(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    label: Text(
                                      '${bot['name']} (${bot['weight']})',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      30,
                                      22,
                                      35,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: const BorderSide(
                                        color: Color(0xFF9D3AE7),
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Description row (scrollable)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            team['description'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              height: 1.4,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
