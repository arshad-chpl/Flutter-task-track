String formatHour(String dateTime) {
  try {
    final DateTime date = DateTime.parse(dateTime);

    return "${date.hour}:00";
  } catch (e) {
    return "";
  }
}
