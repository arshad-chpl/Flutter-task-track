import 'package:flutter/material.dart';
import '../models/app_state.dart';
import '../models/city_model.dart';

class CityListScreen extends StatelessWidget {
  final List<CityModel> cities;

  const CityListScreen({super.key, required this.cities});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/images/background_image.png",
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),

                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),

                      const Text(
                        "Saved Cities",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ],
                  ),
                ),

                // Cities List
                Expanded(
                  child: cities.isEmpty
                      ? const Center(
                          child: Text(
                            "No cities added yet",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),

                          itemCount: cities.length,

                          itemBuilder: (context, index) {
                            final city = cities[index];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 15),

                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: .25),

                                borderRadius: BorderRadius.circular(20),

                                border: Border.all(
                                  color: Colors.white.withValues(alpha: .15),
                                ),
                              ),

                              child: ListTile(
                                onTap: () {
                                  AppState.selectedCity = city;
                                  Navigator.pop(context);
                                },

                                leading: const Icon(
                                  Icons.location_city,
                                  color: Colors.white,
                                ),

                                title: Text(
                                  city.name,
                                  style: const TextStyle(color: Colors.white),
                                ),

                                subtitle: Text(
                                  city.country,
                                  style: const TextStyle(color: Colors.white70),
                                ),

                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
