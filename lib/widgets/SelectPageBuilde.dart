import 'package:flutter/material.dart';
import 'package:nsmeteo/models/cityModel.dart';
import 'package:nsmeteo/models/currentWeatherData.dart';
import 'package:nsmeteo/services/meteoService.dart';
import 'package:nsmeteo/widgets/CurrentWeatherBox.dart';

import '../utils/Ui.dart';
import 'CurrentWeatherBuilder.dart';
import 'FutureWeatherBuilder.dart';

class SelectPageBuilder extends StatefulWidget {
  final cityModel city;
  const SelectPageBuilder({Key? key, required this.city}) : super(key: key);

  @override
  State<SelectPageBuilder> createState() => SelectPageBuilderState(city);
}

class SelectPageBuilderState extends State<SelectPageBuilder> {
  cityModel city;

  SelectPageBuilderState(this.city);
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
