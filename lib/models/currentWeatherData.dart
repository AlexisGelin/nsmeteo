import 'package:nsmeteo/models/clouds.dart';
import 'package:nsmeteo/models/coord.dart';
import 'package:nsmeteo/models/mainWeather.dart';
import 'package:nsmeteo/models/sys.dart';
import 'package:nsmeteo/models/weather.dart';
import 'package:nsmeteo/models/wind.dart';

class currentWeatherData {
  late coord _coord;
  late weather _weather;
  late String base;
  late mainWeather main;
  late double visibility;
  late wind _wind;
  late clouds _clouds;
  late int dt;
  late sys _sys;
  late double timezone;
  late int id;
  late String name;
  late int cod;

  currentWeatherData(
      this._coord,
      this._weather,
      this.base,
      this.main,
      this.visibility,
      this._wind,
      this._clouds,
      this.dt,
      this._sys,
      this.timezone,
      this.id,
      this.name,
      this.cod);
}
