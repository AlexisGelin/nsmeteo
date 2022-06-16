import 'dart:convert';

import 'package:nsmeteo/models/Meteo.dart';
import 'package:http/http.dart' as http;

import '../models/cityModel.dart';
import '../models/futureWeatherData.dart';

// ignore: camel_case_types
class meteoService {
  static Future<CurrentWeatherData> requestCurrentMeteoDataByGeoLoc(
      cityModel cityModel, String? units) async {
    late CurrentWeatherData currentWeatherData;

    units ??= "metric";
// http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}

    var url = Uri.https("api.openweathermap.org", "/data/2.5/weather", {
      'lat': '${cityModel.lat}',
      'lon': '${cityModel.lon}',
      'units': units,
      'limit': '3',
      'appid': 'e6f4a7d38ed14b86bb576f01ec00b341',
      'lang': 'FR'
    });
    var response = await http.get(url);

    if (response.statusCode == 200) {
      currentWeatherData =
          CurrentWeatherData.fromJson(jsonDecode(response.body));
    }
    return currentWeatherData;
  }

  static Future<CurrentWeatherData> requestCurrentMeteoDataByName(
      cityModel cityModel, String? units) async {
    late CurrentWeatherData currentWeatherData;

    units ??= "metric";
// http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}

    var url = Uri.https("api.openweathermap.org", "/data/2.5/weather", {
      'q': cityModel.name,
      'units': units,
      'appid': 'e6f4a7d38ed14b86bb576f01ec00b341',
      'lang': 'FR'
    });
    var response = await http.get(url);

    if (response.statusCode == 200) {
      currentWeatherData =
          CurrentWeatherData.fromJson(jsonDecode(response.body));
    }
    return currentWeatherData;
  }

  static Future<FutureWeatherData> requestFutureMeteoData(
      cityModel cityModel, String? units) async {
    late FutureWeatherData futureWeatherData;

    units ??= "metric";
// http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}

    var url = Uri.https("api.openweathermap.org", "/data/2.5/forecast", {
      'lat': '${cityModel.lat}',
      'lon': '${cityModel.lon}',
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
