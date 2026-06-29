import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherService {
  Future<WeatherModel> getWeather(double latitude, double longitude) async {
    final url =
        "https://api.open-meteo.com/v1/forecast?"
        "latitude=$latitude"
        "&longitude=$longitude"
        "&current="
        "temperature_2m,"
        "relative_humidity_2m,"
        "apparent_temperature,"
        "weather_code,"
        "wind_speed_10m"
        "&hourly="
        "temperature_2m,"
        "weather_code,"
        "precipitation_probability"
        "&daily="
        "weather_code,"
        "temperature_2m_max,"
        "temperature_2m_min,"
        "sunrise,"
        "sunset,"
        "uv_index_max";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return WeatherModel.fromJson(data);
    } else {
      throw Exception("Weather API Failed");
    }
  }
}
