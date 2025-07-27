import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:robowars_app/home_page/widgets/fluid_nav_bar.dart';

class UpdatesPage extends StatefulWidget {
  const UpdatesPage({super.key});

  @override
  State<UpdatesPage> createState() => _UpdatesPageState();

  static Widget buildUpdateCard({
    required String name,
    required String message,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFFD9D9D9),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF8439F9).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.05,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset('assets/images/robovitics logo.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Color(0xFFD9D9D9),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            time,
                            style: const TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
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

  static Widget buildDateDivider(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent,
                    Color(0xFFB84BFF),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFFD9D9D9),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.transparent,
                    Color(0xFFB84BFF),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UpdatesPageState extends State<UpdatesPage> {
  int _currentIndex = 0;
  final Widget logo = SvgPicture.asset(
    'assets/images/robovitics logo.svg',
    height: 40,
    width: 40,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
          right: 10.0, // Don't forget horizontal padding
        ),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF8439F9),
          child: const Icon(Icons.campaign, color: Colors.white),
        ),
      ),
      // Location should be separate
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90 + MediaQuery.of(context).padding.top),
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    logo,
                    const Text(
                      "Updates",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Trajan Pro',
                      ),
                    ),
                    Icon(
                      Icons.account_circle_outlined,
                      color: Color(0xFF9C49E2),
                      size: 45,
                    ),
                  ],
                ),
              ),
              Container(
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
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
      ),

      body: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: 0.04,
              child: SvgPicture.asset(
                'assets/logo.svg',
                width: 300,
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            children: [
              UpdatesPage.buildUpdateCard(
                name: "John Doe",
                message: "The competition schedule has been updated. Please check the new timings for your matches.",
                time: "9:00 am",
              ),
              UpdatesPage.buildUpdateCard(
                name: "Jane Smith",
                message: "Team registration deadline has been extended to Friday. Make sure to submit all required documents.",
                time: "10:30 am",
              ),
              UpdatesPage.buildDateDivider("Yesterday"),
              UpdatesPage.buildUpdateCard(
                name: "Event Coordinator",
                message: "Reminder: Mandatory safety briefing tomorrow at 11 AM in the main auditorium.",
                time: "3:45 pm",
              ),
              UpdatesPage.buildUpdateCard(
                name: "Technical Team",
                message: "New rule update: All robots must pass weight verification before each match.",
                time: "5:20 pm",
              ),
              UpdatesPage.buildDateDivider("May 24"),
              UpdatesPage.buildUpdateCard(
                name: "Organizing Committee",
                message: "Congratulations to Team Phoenix for winning the innovation award!",
                time: "7:00 pm",
              ),
            ],
          ),
        ],
      ),
    );
  }
}