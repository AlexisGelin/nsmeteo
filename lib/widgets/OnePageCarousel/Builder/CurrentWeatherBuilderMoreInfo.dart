import 'package:flutter/material.dart';
import 'package:nsmeteo/models/cityModel.dart';
import 'package:nsmeteo/models/Meteo.dart';
import 'package:nsmeteo/services/meteoService.dart';
import 'package:nsmeteo/widgets/OnePageCarousel/Style/CurrentWeatherBox.dart';
import 'package:nsmeteo/widgets/OnePageCarousel/Style/CurrentWeatherBoxMoreInfo.dart';

class CurrentWeatherBuilderMoreInfo extends StatefulWidget {
  final cityModel city;
  const CurrentWeatherBuilderMoreInfo({Key? key, required this.city}) : super(key: key);

  @override
  State<CurrentWeatherBuilderMoreInfo> createState() =>
      CurrentWeatherBuilderMoreInfoState(city);
}

class CurrentWeatherBuilderMoreInfoState extends State<CurrentWeatherBuilderMoreInfo> {
  cityModel city;

  CurrentWeatherBuilderMoreInfoState(this.city);
  late final Future<CurrentWeatherData> cW;

  @override
  void initState() {
    cW = meteoService.requestCurrentMeteoDataByName(city, "metric");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CurrentWeatherData>(
      future: cW,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CurrentWeatherBoxMoreInfo(cWeatherData: snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

