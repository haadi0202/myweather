import 'dart:convert';

import 'package:http/http.dart';

Future<List?> getTempByCityName({required cityName}) async {
  int? temperature;
  String weather;
  String dayOrNight;
  String time12Hour;
  List? list = [];

  var response = await Future(() => get(Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=b490c231d1fa34cb7c2043118bd64ee8&units=metric")));

  if (response.statusCode == 200) {
    Map<String, dynamic> weatherMap = jsonDecode(response.body);
    temperature = weatherMap["main"]["temp"].round();
    weather = weatherMap["weather"][0]["main"];
    int timeOffset = weatherMap["timezone"];
    dayOrNight = dayOrNightFunc(timeOffset);
    DateTime time = time24Hours(timeOffset);
    time12Hour = convertTo12HourFormat(time.hour, time.minute);
    list.add(temperature);
    list.add(weather);
    list.add(dayOrNight);
    list.add(time12Hour);
    return list;
  } else {
    print("error code ${response.statusCode}");
  }
  return null;
}

String dayOrNightFunc(int timeOffset) {
  DateTime localTime = time24Hours(timeOffset);

  int hour = localTime.hour;
  if (hour > 6 && hour < 18) {
    return "Day";
  } else {
    return "Night";
  }
}

DateTime time24Hours(int timeOffset) {
  int timezoneOffset = timeOffset;

  // Get current UTC time
  DateTime utcNow = DateTime.now().toUtc();

  // Calculate local time by adding the timezone offset
  DateTime localTime = utcNow.add(Duration(seconds: timezoneOffset));
  return localTime;
}

String convertTo12HourFormat(int hour, int minute) {
  String period = hour >= 12 ? 'PM' : 'AM';
  int hour12 = hour % 12;
  hour12 = hour12 == 0 ? 12 : hour12; // Convert 0 to 12 for 12 AM/PM

  String minuteStr =
      minute.toString().padLeft(2, '0'); // Ensure two digits for minutes

  return '$hour12:$minuteStr $period';
}
