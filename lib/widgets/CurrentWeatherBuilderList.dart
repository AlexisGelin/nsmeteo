import 'package:flutter/material.dart';
import 'package:nsmeteo/models/cityModel.dart';
import 'package:nsmeteo/models/Meteo.dart';
import 'package:nsmeteo/services/meteoService.dart';
import 'package:nsmeteo/widgets/OnePageCarousel/Style/CurrentWeatherBox.dart';

import 'CurrentWeatherBoxList.dart';

class CurrentWeatherBuilderList extends StatefulWidget {
  final cityModel city;
  const CurrentWeatherBuilderList({Key? key, required this.city})
      : super(key: key);

  @override
  State<CurrentWeatherBuilderList> createState() =>
      CurrentWeatherBuilderListState(city);
}

class CurrentWeatherBuilderListState extends State<CurrentWeatherBuilderList> {
  cityModel city;

  CurrentWeatherBuilderListState(this.city);
  late final Future<CurrentWeatherData> cW;

  @override
  void initState() {
    cW = meteoService.requestCurrentMeteoData(city, "metric");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CurrentWeatherData>(
      future: cW,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CurrentWeatherBoxList(cWeatherData: snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
