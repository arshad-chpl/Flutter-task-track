import 'package:flutter/material.dart';

import '../models/hourly_weather_model.dart';
import '../models/city_model.dart';
import '../models/saved_cities.dart';
import '../models/app_state.dart';

import '../screens/weather_details_screen.dart';
import '../screens/city_list_screen.dart';

import '../utils/time_formatter.dart';
import '../utils/weather_icon.dart';

class ForecastPanel extends StatelessWidget {
  final List<HourlyWeatherModel> hourly;

  const ForecastPanel({super.key, required this.hourly});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xff2D315E),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(blurRadius: 30, color: Colors.black.withValues(alpha: .3)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: const [
                Expanded(
                  child: Text(
                    "Hourly Forecast",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                    //overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "Weekly Forecast",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),

          // HOURLY LIST
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: hourly.length > 8 ? 8 : hourly.length,
              itemBuilder: (context, index) {
                final item = hourly[index];

                return Container(
                  width: 65,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        index == 0 ? "Now" : formatHour(item.time),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Image.asset(
                        getWeatherImage(item.weatherCode),
                        height: 28,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${item.temperature.round()}°",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // BOTTOM ACTIONS
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.white),

                // ADD / SEARCH CITY
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const WeatherDetailsScreen(),
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.add, color: Colors.black),
                  ),
                ),

                // CITY LIST
                GestureDetector(
                  onTap: () async {
                    final selectedCity = await Navigator.push<CityModel>(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CityListScreen(cities: SavedCities.cities),
                      ),
                    );

                    if (selectedCity != null) {
                      AppState.selectedCity = selectedCity;
                      Navigator.pop(context);
                    }
                  },
                  child: const Icon(Icons.menu, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
