import 'package:flutter/material.dart';

import '../models/app_state.dart';
import '../models/city_model.dart';
import '../models/weather_model.dart';

import '../services/location_service.dart';
import '../services/weather_service.dart';

import '../widgets/weather_card.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  final WeatherService weatherService = WeatherService();

  final LocationService locationService = LocationService();

  WeatherModel? weather;

  String cityName = "";

  bool loading = true;

  @override
  void initState() {
    super.initState();

    loadWeather();
  }

  Future<void> loadWeather() async {
    setState(() {
      loading = true;
    });

    try {
      CityModel city;

      // User selected city
      if (AppState.selectedCity != null) {
        city = AppState.selectedCity!;
      }
      // First app open
      else {
        final result = await locationService.searchCity("Ahmedabad");

        if (result.isEmpty) {
          throw Exception("City not found");
        }

        city = result.first;

        // Save default city
        AppState.selectedCity = city;
      }

      final weatherResult = await weatherService.getWeather(
        city.latitude,

        city.longitude,
      );

      if (!mounted) return;

      setState(() {
        cityName = "${city.name}, ${city.country}";

        weather = weatherResult;

        loading = false;
      });
    } catch (e) {
      debugPrint("HOME WEATHER ERROR : $e");

      if (!mounted) return;

      setState(() {
        weather = null;

        loading = false;
      });
    }
  }

  Future<void> refreshWeather() async {
    await loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,

        children: [
          Image.asset("assets/images/background_image.png", fit: BoxFit.cover),

          SafeArea(
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : weather == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        const Text(
                          "Weather unavailable",

                          style: TextStyle(color: Colors.white),
                        ),

                        const SizedBox(height: 10),

                        ElevatedButton(
                          onPressed: loadWeather,
                          
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: refreshWeather,

                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),

                      child: WeatherCard(
                        city: cityName,
                        temperature: "${weather!.temperature.round()}°",
                        description: "Humidity ${weather!.humidity.round()}%",
                        highLow: "Wind ${weather!.windSpeed.round()} km/h",
                        hourly: weather!.hourly,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
