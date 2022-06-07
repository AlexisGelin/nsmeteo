import 'dart:convert';

import 'package:nsmeteo/models/currentWeatherData.dart';
import 'package:http/http.dart' as http;

import '../models/cityModel.dart';
import '../models/futureWeatherData.dart';

class meteoService {
  static Future<CurrentWeatherData> requestCurrentMeteoData(
      cityModel _cityModel, String? units) async {
    late CurrentWeatherData _currentWeatherData;

    units ??= "metric";
// http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}

    var url = Uri.https("api.openweathermap.org", "/data/2.5/weather", {
      'lat': '${_cityModel.lat}',
      'lon': '${_cityModel.lon}',
      'units': units,
      'appid': 'e6f4a7d38ed14b86bb576f01ec00b341',
      'lang': 'FR'
    });
    var response = await http.get(url);

    if (response.statusCode == 200) {
      _currentWeatherData =
          CurrentWeatherData.fromJson(jsonDecode(response.body));
    }
    return _currentWeatherData;
  }

  static Future<FutureWeatherData> requestFutureMeteoData(
      cityModel _cityModel, String? units) async {
    late FutureWeatherData futureWeatherData;

    units ??= "metric";
// http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}

    var url = Uri.https("api.openweathermap.org", "/data/2.5/forecast", {
      'lat': '${_cityModel.lat}',
      'lon': '${_cityModel.lon}',
      'units': units,
      'appid': 'e6f4a7d38ed14b86bb576f01ec00b341',
      'lang': 'FR'
    });
    var response = await http.get(url);

    if (response.statusCode == 200) {
      futureWeatherData = FutureWeatherData.fromJson(jsonDecode(response.body));
    }
    return futureWeatherData;
  }
}
