import 'package:flutter/material.dart';
import 'package:nsmeteo/models/currentWeatherData.dart';

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
        const SizedBox(
          height: 60,
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Text(
              cWeatherData.name!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontFamily: "DMSans",
                shadows: [
                  Shadow(
                      color: Color.fromARGB(108, 0, 0, 0),
                      offset: Offset(2, 2),
                      blurRadius: 15),
                ],
              ),
            )),
        Text(
          "${cWeatherData.main!.temp!.round()}°",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 60,
            fontFamily: "DMSans",
            shadows: [
              Shadow(
                  color: Color.fromARGB(108, 0, 0, 0),
                  offset: Offset(2, 2),
                  blurRadius: 15),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
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
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: "DMSans",
                      shadows: [
                        Shadow(
                            color: Color.fromARGB(108, 0, 0, 0),
                            offset: Offset(2, 2),
                            blurRadius: 15),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 10,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Max. ${cWeatherData.main!.tempMax!.round()}°",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: "DMSans",
                      shadows: [
                        Shadow(
                            color: Color.fromARGB(108, 0, 0, 0),
                            offset: Offset(2, 2),
                            blurRadius: 15),
                      ],
                    ),
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
