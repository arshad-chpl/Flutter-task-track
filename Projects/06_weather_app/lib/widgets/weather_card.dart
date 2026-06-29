import 'package:flutter/material.dart';

import 'forecast_panel.dart';
import '../models/hourly_weather_model.dart';

class WeatherCard extends StatelessWidget {
  final String city;

  final String temperature;

  final String description;

  final String highLow;

  final List<HourlyWeatherModel> hourly;

  const WeatherCard({
    super.key,

    required this.city,

    required this.temperature,

    required this.description,

    required this.highLow,

    required this.hourly,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 60),

            Text(
              city,

              style: const TextStyle(color: Colors.white, fontSize: 28),
            ),

            const SizedBox(height: 10),

            Text(
              temperature,

              style: const TextStyle(
                color: Colors.white,

                fontSize: 90,

                fontWeight: FontWeight.w200,
              ),
            ),

            Text(
              description,

              style: const TextStyle(color: Colors.white70, fontSize: 18),
            ),

            const SizedBox(height: 8),

            Text(
              highLow,

              style: const TextStyle(color: Colors.white54, fontSize: 14),
            ),

            SizedBox(
              height: 410,

              child: Image.asset(
                "assets/images/house1.png",

                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 120),
          ],
        ),

        Positioned(
          left: 0,

          right: 0,

          bottom: 0,

          child: ForecastPanel(hourly: hourly),
        ),
      ],
    );
  }
}
