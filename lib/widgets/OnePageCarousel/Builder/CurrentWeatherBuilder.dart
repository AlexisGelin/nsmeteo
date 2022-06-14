import 'package:flutter/material.dart';
import 'package:nsmeteo/models/cityModel.dart';
import 'package:nsmeteo/models/Meteo.dart';
import 'package:nsmeteo/services/meteoService.dart';
import 'package:nsmeteo/widgets/OnePageCarousel/Style/CurrentWeatherBox.dart';

class CurrentWeatherBuilder extends StatefulWidget {
  final cityModel city;
  const CurrentWeatherBuilder({Key? key, required this.city}) : super(key: key);

  @override
  State<CurrentWeatherBuilder> createState() =>
      CurrentWeatherBuilderState(city);
}

class CurrentWeatherBuilderState extends State<CurrentWeatherBuilder> {
  cityModel city;

  CurrentWeatherBuilderState(this.city);
  late final Future<CurrentWeatherData> cW;

  @override
  void initState() {
    cW = meteoService.requestCurrentMeteoDataByGeoLoc(city, "metric");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CurrentWeatherData>(
      future: cW,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CurrentWeatherBox(cWeatherData: snapshot.data!, cityName: city.name,);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
