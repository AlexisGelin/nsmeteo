import 'package:flutter/material.dart';
import 'package:nsmeteo/models/currentWeatherData.dart';
import 'package:nsmeteo/widgets/Block.dart';

class CurrentWeatherBox extends StatefulWidget {
  final CurrentWeatherData cWeatherData;
  const CurrentWeatherBox({Key? key, required this.cWeatherData})
      : super(key: key);

  @override
  State<CurrentWeatherBox> createState() =>
      CurrentWeatherBoxState(cWeatherData);
}

class CurrentWeatherBoxState extends State<CurrentWeatherBox> {
  CurrentWeatherData cWeatherData;
  CurrentWeatherBoxState(this.cWeatherData);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BlockSmall(),
        Align(
            alignment: Alignment.topCenter,
            child: Text(
              cWeatherData.name!,
              style: Theme.of(context).textTheme.titleMedium,
            )),
        Text(
          "${cWeatherData.main!.temp!.round()}°",
          style: Theme.of(context).textTheme.titleLarge,
          
        ),
        Text(
          "${cWeatherData.weather![0].description}",
          style: Theme.of(context).textTheme.titleSmall,
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
