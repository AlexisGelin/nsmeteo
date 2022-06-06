import 'package:flutter/material.dart';
import 'package:nsmeteo/models/cityModel.dart';
import 'package:nsmeteo/models/currentWeatherData.dart';
import 'package:nsmeteo/services/meteoService.dart';
import 'package:nsmeteo/widgets/CurrentWeatherBox.dart';

import '../models/futureWeatherData.dart';
import 'FutureWeatherBox.dart';

class FutureWeatherBuilder extends StatefulWidget {
  final cityModel city;
  const FutureWeatherBuilder({Key? key, required this.city}) : super(key: key);

  @override
  State<FutureWeatherBuilder> createState() => FutureWeatherBuilderState(city);
}

class FutureWeatherBuilderState extends State<FutureWeatherBuilder> {
  cityModel city;

  FutureWeatherBuilderState(this.city);
  late final Future<FutureWeatherData> cW;

  @override
  void initState() {
    cW = meteoService.requestFutureMeteoData(city, "metric");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FutureWeatherData>(
      future: cW,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureWeatherBox(fWeatherData: snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}