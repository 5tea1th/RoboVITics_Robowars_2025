import 'package:flutter/material.dart';
import 'package:robowars_app/features/screens/home_screen/guess_game/pop_up.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:gradient_borders/gradient_borders.dart';

class GuessGame extends StatefulWidget {
  const GuessGame({super.key});

  @override
  State<GuessGame> createState() => _GuessGameState();
}

class _GuessGameState extends State<GuessGame> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int totalPages = 6;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          border: GradientBoxBorder(
            width: 3,
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 93, 62, 137),
                Color.fromRGBO(119, 95, 154, 0.98),
                Color.fromARGB(255, 161, 146, 186),
              ],
            ),
          ),
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(255, 49, 49, 49),
        ),
        height: 210,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: PageScrollPhysics(),
                controller: _pageController,
                itemCount: totalPages,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) => Container(
                  height: 600,
                  width: double.infinity,
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => PopUpCard(),
                        );
                      },
                      child: GradientText(
                        'Click for Guess Game',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                        colors: [
                          Colors.purple[500]!,
                          Colors.purple[300]!,
                          Colors.purple[100]!,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      if (_currentPage > 0) {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    icon: Icon(Icons.arrow_back_ios, color: Colors.grey[300]),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      totalPages,
                      (index) => Container(
                        height: 8,
                        width: 8,
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Colors.purple[700]
                              : Colors.grey[500],
                        ),
                      ),
                    ),
                  ),

                  IconButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      if (_currentPage < totalPages - 1) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
