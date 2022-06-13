import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nsmeteo/models/currentWeatherData.dart';
import 'package:nsmeteo/utils/Block.dart';



class CurrentWeatherBox extends StatefulWidget {
  final CurrentWeatherData cWeatherData;
  final String cityName;
  const CurrentWeatherBox({Key? key, required this.cWeatherData, required this.cityName})
      : super(key: key);

  @override
  State<CurrentWeatherBox> createState() =>
      CurrentWeatherBoxState(cWeatherData,cityName);
}




class CurrentWeatherBoxState extends State<CurrentWeatherBox> {
  CurrentWeatherData cWeatherData;
  String cityName;
  CurrentWeatherBoxState(this.cWeatherData, this.cityName);

  String capitalize(var str) {
      return "${str[0].toUpperCase()}${str.substring(1).toLowerCase()}";
    }

  @override
  Widget build(BuildContext context) {

    
    return Column(
      children: [
        const BlockSmall(),
        Align(
            alignment: Alignment.topCenter,
            child: Text(
              cityName,
              style: Theme.of(context).textTheme.titleMedium,
            )),
        Text(
          "${cWeatherData.main!.temp!.round()}°",
          style: Theme.of(context).textTheme.titleLarge,
          
        ),
        Text(
          capitalize(cWeatherData.weather![0].description),
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
