import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

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
                'assets/images/robovitics logo.svg',
                width: 300,
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('updates')
                .orderBy('timestamp', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "No updates yet.",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              final docs = snapshot.data!.docs;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_scrollController.hasClients) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              });

              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final update = docs[index].data() as Map<String, dynamic>;
                  final timestamp = update['timestamp'] as Timestamp?;
                  final dateTime = timestamp?.toDate() ?? DateTime.now();
                  final now = DateTime.now();
                  final isToday = dateTime.day == now.day &&
                                  dateTime.month == now.month &&
                                  dateTime.year == now.year;
                  final currentDate = isToday ? "Today" : "${dateTime.day}/${dateTime.month}/${dateTime.year}";
                  final time = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

                  final previousTimestamp = index == 0
                      ? null
                      : (docs[index - 1].data() as Map<String, dynamic>)['timestamp'] as Timestamp?;
                  final previousDateTime = previousTimestamp?.toDate();
                  final isPreviousToday = previousDateTime != null &&
                                          previousDateTime.day == now.day &&
                                          previousDateTime.month == now.month &&
                                          previousDateTime.year == now.year;
                  final previousDate = previousDateTime == null
                      ? null
                      : isPreviousToday ? "Today" : "${previousDateTime.day}/${previousDateTime.month}/${previousDateTime.year}";

                  final showDivider = currentDate != previousDate;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showDivider)
                        UpdatesPage.buildDateDivider(currentDate),
                      UpdatesPage.buildUpdateCard(
                        name: update['name'] ?? "",
                        message: update['message'] ?? "",
                        time: time,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}