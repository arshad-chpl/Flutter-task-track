String getWeatherImage(int code) {
  if (code == 0) {
    return "assets/images/sunny.png";
  } else if (code >= 1 && code <= 3) {
    return "assets/images/cloudy.png";
  } else if (code >= 61 && code <= 65) {
    return "assets/images/cloudy.png";
  } else if (code >= 95) {
    return "assets/images/sunny.png";
  }

  return "assets/images/cloudy.png";
}

String getWeatherDescription(int code) {
  if (code == 0) {
    return "Clear Sky";
  } else if (code >= 1 && code <= 3) {
    return "Cloudy";
  } else if (code >= 61 && code <= 65) {
    return "Rain";
  } else if (code >= 95) {
    return "Thunderstorm";
  }

  return "Unknown";
}
