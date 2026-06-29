import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/city_model.dart';
import 'package:flutter/foundation.dart';

class LocationService {
  Future<List<CityModel>> searchCity(String city) async {
    final url =
        "https://geocoding-api.open-meteo.com/v1/search"
        "?name=$city"
        "&count=10"
        "&language=en"
        "&format=json";

    debugPrint(url);

    final response = await http.get(Uri.parse(url));

    debugPrint(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["results"] == null) {
        return [];
      }

      return (data["results"] as List)
          .map((e) => CityModel.fromJson(e))
          .toList();
    }

    throw Exception("API Error ${response.statusCode}");
  }
}
