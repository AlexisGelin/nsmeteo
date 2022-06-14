import 'package:flutter/material.dart';
import 'package:nsmeteo/models/cityModel.dart';
import 'package:nsmeteo/models/Meteo.dart';
import 'package:nsmeteo/services/meteoService.dart';
import 'package:nsmeteo/widgets/OnePageCarousel/Style/CurrentWeatherBox.dart';
import 'package:nsmeteo/widgets/OnePageCarousel/Builder/CurrentWeatherBuilderMoreInfo.dart';

import '../../utils/Ui.dart';
import 'Builder/CurrentWeatherBuilder.dart';
import 'Builder/FutureWeatherBuilder.dart';

class CurrentPageBuilder extends StatefulWidget {
  final cityModel city;
  const CurrentPageBuilder({Key? key, required this.city}) : super(key: key);

  @override
  State<CurrentPageBuilder> createState() => CurrentPageBuilderState(city);
}

class CurrentPageBuilderState extends State<CurrentPageBuilder> {
  cityModel city;

  CurrentPageBuilderState(this.city);
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
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/background/${UiUtils.getBackground("${snapshot.data!.weather![0].id}")}"),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              children: <Widget>[
                CurrentWeatherBuilder(city: city),
                FutureWeatherBuilder(city: city),
                CurrentWeatherBuilderMoreInfo(city: city),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
