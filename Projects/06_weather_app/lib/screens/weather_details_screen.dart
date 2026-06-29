import 'dart:async';
import 'package:flutter/material.dart';

import '../models/city_model.dart';
import '../models/weather_model.dart';
import '../models/saved_cities.dart';
import '../models/app_state.dart';

import '../services/location_service.dart';
import '../services/weather_service.dart';

import '../utils/weather_icon.dart';
import '../widgets/weather_location_card.dart';
import '../widgets/weather_shimmer_card.dart';

class WeatherDetailsScreen extends StatefulWidget {
  const WeatherDetailsScreen({super.key});

  @override
  State<WeatherDetailsScreen> createState() =>
      _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  final TextEditingController searchController = TextEditingController();

  final LocationService locationService = LocationService();
  final WeatherService weatherService = WeatherService();

  List<CityModel> cities = [];
  bool isLoading = false;

  Timer? debounce;

  void onSearchChanged(String value) {
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      searchCity(value);
    });
  }

  Future<void> searchCity(String value) async {
    if (value.trim().length < 2) {
      setState(() => cities.clear());
      return;
    }

    try {
      setState(() => isLoading = true);

      final result = await locationService.searchCity(value);

      setState(() {
        cities = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background_image.png",
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white),
                      ),
                      const Text(
                        "Weather",
                        style:
                            TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // SEARCH BOX
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha:.25),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: onSearchChanged,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Search city",
                        hintStyle:
                            TextStyle(color: Colors.white54),
                        prefixIcon:
                            Icon(Icons.search, color: Colors.white54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // LIST AREA
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: isLoading
                          ? ListView.builder(
                              itemCount: 6,
                              itemBuilder: (_, __) =>
                                  const WeatherShimmerCard(),
                            )
                          : cities.isEmpty
                              ? const Center(
                                  child: Text(
                                    "Search city",
                                    style: TextStyle(
                                        color: Colors.white70),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: cities.length,
                                  itemBuilder: (context, index) {
                                    final city = cities[index];

                                    return FutureBuilder<WeatherModel>(
                                      future: weatherService.getWeather(
                                        city.latitude,
                                        city.longitude,
                                      ),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return const SizedBox(
                                              height: 80);
                                        }

                                        final weather =
                                            snapshot.data!;

                                        return TweenAnimationBuilder(
                                          duration: const Duration(
                                              milliseconds: 300),
                                          tween: Tween<double>(
                                              begin: 0, end: 1),
                                          builder: (context, value,
                                              child) {
                                            return Opacity(
                                              opacity: value,
                                              child: Transform.translate(
                                                offset: Offset(
                                                    0, 20 * (1 - value)),
                                                child: child,
                                              ),
                                            );
                                          },
                                          child: GestureDetector(
                                            onTap: () {
                                              AppState.selectedCity =
                                                  city;

                                              if (!SavedCities.cities
                                                  .any((c) =>
                                                      c.latitude ==
                                                          city.latitude &&
                                                      c.longitude ==
                                                          city.longitude)) {
                                                SavedCities.cities
                                                    .add(city);
                                              }

                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(
                                                      bottom: 20),
                                              child:
                                                  WeatherLocationCard(
                                                temperature:
                                                    "${weather.temperature.round()}°",
                                                city:
                                                    "${city.name}, ${city.country}",
                                                highLow:
                                                    "Humidity ${weather.humidity.round()}%",
                                                description:
                                                    getWeatherDescription(
                                                        weather
                                                            .weatherCode),
                                                image:
                                                    getWeatherImage(
                                                        weather
                                                            .weatherCode),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
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
}