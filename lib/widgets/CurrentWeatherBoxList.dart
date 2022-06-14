import 'package:flutter/material.dart';
import 'package:nsmeteo/models/Meteo.dart';
import 'package:nsmeteo/utils/Block.dart';

class CurrentWeatherBoxList extends StatefulWidget {
  final CurrentWeatherData cWeatherData;
  const CurrentWeatherBoxList({Key? key, required this.cWeatherData})
      : super(key: key);

  @override
  State<CurrentWeatherBoxList> createState() =>
      CurrentWeatherBoxListState(cWeatherData);
}

class CurrentWeatherBoxListState extends State<CurrentWeatherBoxList> {
  CurrentWeatherData cWeatherData;
  CurrentWeatherBoxListState(this.cWeatherData);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${cWeatherData.main!.temp!.round()}°",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 0.0),
          height: 45.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 10,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Min. ${cWeatherData.main!.tempMin!.round()}°",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              const BlockSmall(),
              SizedBox(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Max. ${cWeatherData.main!.tempMax!.round()}°",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
