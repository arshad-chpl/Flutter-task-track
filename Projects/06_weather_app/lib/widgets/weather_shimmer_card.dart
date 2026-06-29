import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class WeatherShimmerCard extends StatelessWidget {
  const WeatherShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
  duration: const Duration(seconds: 2),
  interval: const Duration(seconds: 1),
  color: Colors.white,
  colorOpacity: 0.3,
  enabled: true,

  child: Container(
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.all(16),
    height: 90,
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: .1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Container(width: 40, height: 40, color: Colors.white),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 10, width: 120, color: Colors.white),
              const SizedBox(height: 8),
              Container(height: 10, width: 80, color: Colors.white),
            ],
          ),
        ),
        Container(width: 40, height: 20, color: Colors.white),
      ],
    ),
  ),
    );
  }
}