import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  bool isTeamsSelected = true;

  final List<Map<String, dynamic>> teamsData = List.generate(
    10,
        (_) => {
      'name': 'Team Orcus',
      'bots': [
        {'name': 'Raven', 'weight': '60 kg'},
        {'name': 'Vulcan', 'weight': '15 kg'},
      ],
      'description':
      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using , making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildFadingLine(),
          const SizedBox(height: 24),
          _buildToggle(),
          const SizedBox(height: 24),
          Expanded(child: _buildAnimatedBody()),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: SvgPicture.asset(
          'assets/robovitics logo.svg',
          height: 28,
          width: 28,
        ),
      ),
      title: Text(
        isTeamsSelected ? 'Teams' : 'Table',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Icon(
            Icons.account_circle_outlined,
            color: Color(0xFF9D3AE7),
            size: 40,
          ),
        ),
      ],
    );
  }


  Widget _buildFadingLine() {
    return Container(
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Color(0xFF9D3AE7), Colors.transparent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }

  Widget _buildToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 240,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              _toggleButton(label: 'Teams', selectTeams: true),
              _toggleButton(label: 'Table', selectTeams: false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _toggleButton({required String label, required bool selectTeams}) {
    final selected = isTeamsSelected == selectTeams;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          isTeamsSelected = selectTeams;
        }),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          decoration: BoxDecoration(
            gradient: selected
                ? const LinearGradient(
              colors: [Color(0xFF9D3AE7), Color.fromARGB(255, 200, 141, 245)],
              begin: Alignment.centerLeft,
              end: Alignment.bottomCenter,
            )
                : null,
            color: selected ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selected ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildAnimatedBody() =>
      AnimatedSwitcher(
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
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 40),
            itemCount: teamsData.length,
            separatorBuilder: (_, __) => _buildFadingLine(),
            itemBuilder: (context, index) {
              final team = teamsData[index];
              final bots = (List<Map<String, dynamic>>.from(team['bots'])
                ..sort((a, b) => a['name'] == 'Raven' ? -1 : 1)).toList();

              return GestureDetector(
                onTap: () => _showTeamPopup(context, team),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(  // Added SizedBox to constrain width
                    width: double.infinity,  // Ensure full width
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
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              gradient: const LinearGradient(
                                colors: [Colors.deepPurple, Colors.black],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(  // This Expanded is now properly placed
                          child: Column(
                            mainAxisSize: MainAxisSize.min,  // Added this
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15, top: 4),
                                child: Text(
                                  team['name'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Column(  // Removed Expanded from here
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: bots.map<Widget>((bot) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 6, left: 15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFF9D3AE7), Color(0xFF6A1B9A)],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.all(1.5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [Colors.white, Colors.white],
                                            begin: Alignment.center,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius: BorderRadius.circular(18),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
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
                        border: Border.all(color: Colors.grey.shade400, width: 1),

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
                              children: const [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Matches", style: TextStyle(color: Colors.white)),
                                    Text("Won", style: TextStyle(color: Colors.white)),
                                    Text("Lost", style: TextStyle(color: Colors.white)),
                                    Text("Points", style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("3", style: TextStyle(color: Color(0xFF9D3AE7))),
                                    Text("1", style: TextStyle(color: Color(0xFF9D3AE7))),
                                    Text("2", style: TextStyle(color: Color(0xFF9D3AE7))),
                                    Text("2", style: TextStyle(color: Color(0xFF9D3AE7))),
                                  ],
                                ),
                              ],
                            ),
                          )
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
                                child: Text(
                                  team['name'],
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
                                child: Icon(Icons.close, size: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 90,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(Icons.image, color: Colors.white38),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: team['bots'].map<Widget>((bot) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Chip(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      label: Text('${bot['name']} (${bot['weight']})'),
                                      labelStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      backgroundColor: Color.fromARGB(255, 30, 22, 35),
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
                        GridView.count(
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