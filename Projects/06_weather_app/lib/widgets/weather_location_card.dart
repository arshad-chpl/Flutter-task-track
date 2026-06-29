import 'package:flutter/material.dart';

class WeatherLocationCard extends StatelessWidget {
  final String temperature;
  final String city;
  final String highLow;
  final String description;
  final String image;

  const WeatherLocationCard({
    super.key,

    required this.temperature,

    required this.city,

    required this.highLow,

    required this.description,

    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,

      width: double.infinity,

      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),

        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,

              end: Alignment.bottomRight,

              colors: [Color(0xff6844FF), Color(0xff392080)],
            ),
          ),

          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      temperature,

                      style: const TextStyle(
                        color: Colors.white,

                        fontSize: 45,

                        height: .9,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      highLow,

                      style: const TextStyle(
                        color: Colors.white70,

                        fontSize: 11,
                      ),
                    ),

                    Text(
                      city,

                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),

                    const Spacer(),

                    Align(
                      alignment: Alignment.bottomRight,

                      child: Text(
                        description,

                        style: const TextStyle(
                          color: Colors.white70,

                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                right: 10,

                top: 5,

                child: Image.asset(
                  image,

                  height: 100,

                  width: 100,

                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
