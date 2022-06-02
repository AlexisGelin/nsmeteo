import 'dart:convert';

import 'package:nsmeteo/models/currentWeatherData.dart';
import 'package:http/http.dart' as http;

class meteoService {
  static Future<currentWeatherData> getCityData(String city) async {
    currentWeatherData _currentWeatherData;

// http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}

    var url = Uri.https("api.openweathermap.org", "/geo/1.0/direct", {
      'q': city,
      'limit': "50",
      'appid': 'e6f4a7d38ed14b86bb576f01ec00b341'
    });
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
    }
    return _currentWeatherData;
  }
}
