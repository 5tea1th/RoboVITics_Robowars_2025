import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:robowars_app/features/screens/home_screen/guess_game/prediction.dart';

import 'leaderboard.dart';


class PopUpCard extends StatefulWidget {
  const PopUpCard({super.key});

  @override
  State<PopUpCard> createState() => _PopUpCardState();
}

class _PopUpCardState extends State<PopUpCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late TabController _tabController;
  late Animation<double> _scaleAnimation;
  bool _isPredictionExpanded = false;
  bool _isLeaderboardTabActive = false;
  late PredictionTab _predictionTab;

  void _handlePredictionExpand(bool isExpanded) {
    setState(() {
      _isPredictionExpanded = isExpanded;
    });
  }

  void _handleTabSelection() {
    setState(() {
      _isLeaderboardTabActive = _tabController.index == 1;
      if (_tabController.index == 1) {
        _isPredictionExpanded = false;
      }
    });
  }

  void _handlePredictionTabClick() {
    setState(() {
      _isLeaderboardTabActive = false;
      _predictionTab = PredictionTab(
        onExpandChanged: _handlePredictionExpand,
        onTabClicked: () => _handlePredictionTabClick(),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _controller.forward();
    _predictionTab = PredictionTab(
      onExpandChanged: _handlePredictionExpand,
      onTabClicked: () => _handlePredictionTabClick(),
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = [
      Color.fromARGB(255, 193, 110, 234),
      const Color.fromARGB(255, 171, 89, 233),
      //const Color.fromARGB(255, 144, 122, 184),
      //const Color.fromARGB(255, 125, 44, 182),
      const Color.fromARGB(255, 190, 167, 225),
    ];
    final double currentHeight = _isLeaderboardTabActive
        ? 550
        : _isPredictionExpanded
        ? 350
        : 250;

    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.black,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 350, maxHeight: currentHeight),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xFF1A1A2E),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: GradientBoxBorder(
                width: 3,
                gradient: LinearGradient(colors: gradientColors),
              ),
              boxShadow: [
                BoxShadow(
                  color: gradientColors[1].withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Guess It',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30, // Outer circle diameter
                          height: 30, // Outer circle diameter
                          child: IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Color.fromARGB(
                                255,
                                137,
                                44,
                                225,
                              ),
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(
                                4,
                              ), // Adjusts space between icon and edge
                            ),
                            iconSize: 20, // Icon graphic size
                            icon: Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      height: 30,
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(colors: gradientColors),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: const [
                          Tab(text: 'Prediction'),
                          Tab(text: 'Leaderboard'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: _isLeaderboardTabActive
                            ? 500 // More space for leaderboard
                            : _isPredictionExpanded
                            ? 300
                            : 200,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            SingleChildScrollView(
                              child: PredictionTab(
                                onTabClicked: () {
                                  setState() => _isLeaderboardTabActive = false;
                                },
                                onExpandChanged: _handlePredictionExpand,
                              ),
                            ),
                            LeaderboardTab(
                              onTabClicked: () {
                                setState(() {
                                  _isLeaderboardTabActive = true;
                                  // _isPredictionExpanded = false;
                                });
                              },
                            ),
                          ],
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
  }
}
