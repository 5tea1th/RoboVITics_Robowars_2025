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
      final snapshot = await FirebaseFirestore.instance
          .collection('team')
          .get();

      final data = snapshot.docs
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
              'bots': (team['bots'] as Map<String, dynamic>? ?? {}).entries
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
                alignment: isTeamsSelected ? Alignment.centerLeft : Alignment.centerRight,
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
                      onTap: () => setState(() {
                        isTeamsSelected = true;
                      }),
                      child: Container(
                        height: 38,
                        alignment: Alignment.center,
                        child: Text(
                          'Teams',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isTeamsSelected ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        isTeamsSelected = false;
                      }),
                      child: Container(
                        height: 38,
                        alignment: Alignment.center,
                        child: Text(
                          'Table',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: !isTeamsSelected ? Colors.black : Colors.white,
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
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF9D3AE7), width: 1.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 40),
              itemCount: teamsData.length,
              itemBuilder: (context, index) {
                final team = teamsData[index];
                final bots = (List<Map<String, dynamic>>.from(
                  team['bots'],
                )..sort((a, b) => a['name'] == 'Raven' ? -1 : 1)).toList();

                return GestureDetector(
                  onTap: () => _showTeamPopup(context, team),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Team image container
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child:
                                (team['image'] != null &&
                                    team['image'].toString().isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.network(
                                      team['image'],
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Colors.deepPurple,
                                          Colors.black,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                  )),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    top: 4,
                                  ),
                                  child: Text(
                                    team['name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: bots.map<Widget>((bot) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 6,
                                        left: 15,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF9D3AE7),
                                              Color(0xFF6A1B9A),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(1.5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Colors.white,
                                                Colors.white,
                                              ],
                                              begin: Alignment.center,
                                              end: Alignment.centerRight,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          child: Text(
                                            '${bot['name']} (${bot['weight']})',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // Fade at bottom
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 40,
          child: IgnorePointer(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildTableView() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: ListView.builder(
      itemCount: teamsData.length,
      itemBuilder: (context, index) {
        final team = teamsData[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF9D3AE7), width: 1.5),
          ),
          child: Row(
            children: [
              // Rank Number - no background
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
              // Right Section (gradient background + grey border)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [Color(0x1AFFCCFF), Color(0x1A9D3AE7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                        color: Colors.black12,
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          // Team image
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: const LinearGradient(
                                colors: [Colors.grey, Colors.black],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Stats
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Matches",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "Won",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "Lost",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "Points",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${team['matches']}",
                                        style: const TextStyle(
                                          color: Color(0xFF9D3AE7),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        "${team['won']}",
                                        style: const TextStyle(
                                          color: Color(0xFF9D3AE7),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        "${team['lost']}",
                                        style: const TextStyle(
                                          color: Color(0xFF9D3AE7),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        "${team['points']}",
                                        style: const TextStyle(
                                          color: Color(0xFF9D3AE7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF9D3AE7)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF9D3AE7).withAlpha(180),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 32),
                            Expanded(
                              child: Center(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 220,
                                  ),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (team['image'] != null &&
                                    team['image'].toString().isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      team['image'],
                                      width: 90,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    width: 90,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Icon(
                                      Icons.image,
                                      color: Colors.white38,
                                    ),
                                  )),
                            const SizedBox(width: 16),
                            Flexible(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: team['bots'].map<Widget>((bot) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
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
                                        backgroundColor: Color.fromARGB(
                                          255,
                                          30,
                                          22,
                                          35,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
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
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          team['description'],
                          style: const TextStyle(
                            color: Colors.white,
                            height: 1.4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Achievements",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 200),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 2.8,
                            children: List.generate(
                              6,
                              (i) => Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Colors.black, Colors.black12],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Chip(
                                  label: const Text('Vulcan(15 kg)'),
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.black,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(
                                      color: Color(0xFF9D3AE7),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
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
          ),
        );
      },
    );
  }
}
