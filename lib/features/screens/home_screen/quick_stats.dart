import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class QuickStats extends StatelessWidget {
  final Map<String, String> stats;

  const QuickStats({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final entries = stats.entries.toList();

    return SizedBox(
      width: 335,
      height: 236,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Stats',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(entries.length, (index) {
                final entry = entries[index];
                return _statCard(entry.key, entry.value, index);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, int index) {
    // Configurations per box
    late Alignment gradientAlign;
    late Alignment gradientBegin;
    late Alignment gradientEnd;
    late BorderRadius borderRadius;

    switch (index) {
      case 0: // Top-left (Quadrant IV) - FIXED INNER CIRCLE
        gradientAlign = Alignment.bottomRight;
        gradientBegin = Alignment.topRight;
        gradientEnd = Alignment.bottomLeft;
        borderRadius = const BorderRadius.only(
          topLeft: Radius.circular(150), // Only round the inner circle's corner
        );
        break;
      case 1: // Top-right (Quadrant I)
        gradientAlign = Alignment.bottomLeft;
        gradientBegin = Alignment.bottomLeft;
        gradientEnd = Alignment.topRight;
        borderRadius = const BorderRadius.only(topRight: Radius.circular(150));
        break;
      case 2: // Bottom-left (Quadrant III)
        gradientAlign = Alignment.topRight;
        gradientBegin = Alignment.topRight;
        gradientEnd = Alignment.bottomLeft;
        borderRadius = const BorderRadius.only(
          bottomLeft: Radius.circular(150),
        );
        break;
      case 3: // Bottom-right (Quadrant II)
        gradientAlign = Alignment.topLeft;
        gradientBegin = Alignment.topLeft;
        gradientEnd = Alignment.bottomRight;
        borderRadius = const BorderRadius.only(
          bottomRight: Radius.circular(150),
        );
        break;
      default:
        gradientAlign = Alignment.bottomRight;
        gradientBegin = Alignment.bottomRight;
        gradientEnd = Alignment.topLeft;
        borderRadius = const BorderRadius.only(
          bottomLeft: Radius.circular(150),
        );
    }

    return Container(
      width: 143,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.0,
        ), // Outer container remains rounded
        border: Border.all(color: const Color(0xFF6D37C4), width: 1.5),
      ),
      child: Stack(
        children: [
          Align(
            alignment: gradientAlign,
            child: ClipRRect(
              // Clip the inner gradient to force a perfect circle
              borderRadius: borderRadius,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0x73000000), Color(0x73A74FEF)],
                    begin: gradientBegin,
                    end: gradientEnd,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: const TextStyle(fontSize: 13, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
