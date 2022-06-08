import 'dart:convert';

import 'package:nsmeteo/models/cityModel.dart';
import 'package:http/http.dart' as http;

class geoCodingService {
  static Future<List<cityModel>> getCityData(String city) async {
    List<cityModel> cityModelsList = [];

// http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}

    var url = Uri.http("api.openweathermap.org", "/geo/1.0/direct", {
      'q': city,
      'limit': "50",
      'appid': 'e6f4a7d38ed14b86bb576f01ec00b341'
    });

    var response = await http.get(url);

    var contryList = await getContryNameByCode();

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      for (var data in jsonResponse) {
        cityModel citymodel = cityModel(data["name"], data["lat"], data["lon"],
            contryList[data["country"]], data["state"]);
        cityModelsList.add(citymodel);
      }
    }
    return cityModelsList;
  }

  static dynamic getContryNameByCode() async {
    var url2 = Uri.http("country.io", "/names.json");
    var response2 = await http.get(url2);
    return jsonDecode(response2.body);
  }
}
