import 'hourly_weather_model.dart';

class WeatherModel {
  final double temperature;
  final double humidity;
  final double windSpeed;
  final int weatherCode;
  final List<HourlyWeatherModel> hourly;

  WeatherModel({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.hourly,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json["current"] ?? {};
    final hourly = json["hourly"] ?? {};

    List<HourlyWeatherModel> hourlyList = [];

    final times = hourly["time"] ?? [];
    final temps = hourly["temperature_2m"] ?? [];
    final codes = hourly["weather_code"] ?? [];

    for (int i = 0; i < times.length; i++) {
      hourlyList.add(
        HourlyWeatherModel(
          time: times[i],
          temperature: (temps[i] ?? 0).toDouble(),
          weatherCode: codes[i] ?? 0,
        ),
      );
    }

    return WeatherModel(
      temperature: (current["temperature_2m"] ?? 0).toDouble(),
      humidity: (current["relative_humidity_2m"] ?? 0).toDouble(),
      windSpeed: (current["wind_speed_10m"] ?? 0).toDouble(),
      weatherCode: current["weather_code"] ?? 0,
      hourly: hourlyList,
    );
  }
}
