class CityModel {
  final String name;

  final double latitude;

  final double longitude;

  final String country;

  CityModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json["name"],

      latitude: json["latitude"],

      longitude: json["longitude"],

      country: json["country"] ?? "",
    );
  }
}
