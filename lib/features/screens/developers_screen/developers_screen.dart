import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OurTeamPage extends StatefulWidget {
  const OurTeamPage({super.key});

  @override
  State<OurTeamPage> createState() => _OurTeamPageState();
}

class _OurTeamPageState extends State<OurTeamPage> {
  final List<Map<String, String>> teamMembers = const [
    {"name": "Arunabh Gupta", "role": "Lead Developer"},
    {"name": "Lakshya Gupta", "role": "Lead Developer"},
    {"name": "Aakash Gurumurthi", "role": "Lead Developer"},
    {"name": "Anirban Haldar", "role": "Lead Designer"},
    {"name": "Pradnya Sharma", "role": "Lead Designer"},
    {"name": "Arnav Srivastava", "role": "Lead Designer"},
    {"name": "Aakashdip Dey", "role": "Lead Designer"},
    {"name": "G Bramarambika", "role": "Developer"},
    {"name": "R.Jacinth", "role": "Developer"},
    {"name": "Vidit Narayan Panigrahi", "role": "Developer"},
    {"name": "Dharnishwaran M", "role": "Developer"},
    {"name": "Poojikasri V", "role": "Developer"},
    {"name": "Abhisri Ghosh Choudhury", "role": "Developer"},
    {"name": "Aaditya Chourasia", "role": "Developer"},
  ];

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
              surfaceTintColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/logo.svg', height: 30, width: 30),
                  const SizedBox(width: 8),
                  const Text(
                    "Team Members",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Trajan Pro',
                    ),
                  ),
                ],
              ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ), // 👈 Added padding here
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFB84BFF)),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: teamMembers.length,
            itemBuilder: (context, index) {
              final member = teamMembers[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member['name']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            member['role']!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
