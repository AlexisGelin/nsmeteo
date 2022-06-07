import 'package:flutter/material.dart';
import 'package:nsmeteo/models/currentWeatherData.dart';

import '../models/futureWeatherData.dart';
import '../utils/TranformData.dart';

class FutureWeatherBox extends StatefulWidget {
  final FutureWeatherData fWeatherData;
  const FutureWeatherBox({Key? key, required this.fWeatherData})
      : super(key: key);

  @override
  State<FutureWeatherBox> createState() => FutureWeatherBoxState(fWeatherData);
}

class FutureWeatherBoxState extends State<FutureWeatherBox> {
  FutureWeatherData fWeatherData;
  late List<List<dynamic>> MaxMinDay;
  FutureWeatherBoxState(this.fWeatherData) {
    this.MaxMinDay = TransformData.MinMaxByDays(fWeatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Align(
          child: SizedBox(
            height: 130,
            width: 300,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 50,
                  child: ListView(children: <Widget>[
                    Text(
                      "${DateTime.parse("${fWeatherData.list![index].dtTxt}").hour} h",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.abc),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${fWeatherData.list![index].main!.temp!.round()} °",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ]),
                );
              },
              itemCount: 8,
            ),
          ),
        ),
        SizedBox(
          height: 300,
          width: 300,
          child: ListView.builder(
            itemBuilder: (context, index) {
              String txt;
              if (index == 0) {
                txt = "Auj.";
              } else {
                txt =
                    TransformData.ConvertDayInFrench("${MaxMinDay[index][2]}");
              }
              return Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: 300,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Text(
                          txt,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${MaxMinDay[index][0]} °",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${MaxMinDay[index][1]} °",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            itemCount: MaxMinDay.length,
          ),
        ),
      ],
    );
  }
}
