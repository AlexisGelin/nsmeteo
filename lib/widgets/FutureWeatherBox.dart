import 'package:flutter/material.dart';
import 'package:nsmeteo/models/currentWeatherData.dart';

import '../models/futureWeatherData.dart';

class FutureWeatherBox extends StatefulWidget {
  final FutureWeatherData fWeatherData;
  const FutureWeatherBox({Key? key, required this.fWeatherData})
      : super(key: key);

  @override
  State<FutureWeatherBox> createState() => FutureWeatherBoxState(fWeatherData);
}

class FutureWeatherBoxState extends State<FutureWeatherBox> {
  FutureWeatherData fWeatherData;
  FutureWeatherBoxState(this.fWeatherData);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Text(
              "${fWeatherData.list![index].main!.temp!.round()}",
              style: const TextStyle(color: Colors.white, fontSize: 16),
            );
          },
          itemCount: fWeatherData.list!.length,
        ),
      ],
    );
  }
}
