import 'package:flutter/material.dart';
import 'package:nsmeteo/models/currentWeatherData.dart';
import 'package:nsmeteo/widgets/Block.dart';

import '../models/futureWeatherData.dart';
import '../utils/TranformData.dart';
import '../utils/Ui.dart';

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
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 145,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  String dtt;
                  if (DateTime.parse("${fWeatherData.list![index].dtTxt}")
                          .hour <
                      10) {
                    dtt =
                        "0${DateTime.parse("${fWeatherData.list![index].dtTxt}").hour} h";
                  } else {
                    dtt =
                        "${DateTime.parse("${fWeatherData.list![index].dtTxt}").hour} h";
                  }

                  String icons = UiUtils.getIcons(
                      "${fWeatherData.list![index].weather![0].id}");
                  return SizedBox(
                    width: 50,
                    child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Text(
                            dtt,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const BlockSmall(),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Image(
                              image: AssetImage(
                                  "assets/images/meteoIcones/${icons}"),
                              width: 24,
                            ),
                          ),
                          const BlockSmall(),
                          Text(
                            "${fWeatherData.list![index].main!.temp!.round()} °",
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ]),
                  );
                },
                itemCount: 9,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: SizedBox(
              height: 230,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    String txt;
                    if (index == 0) {
                      txt = "Auj.";
                    } else {
                      txt = TransformData.ConvertDayInFrench(
                          "${MaxMinDay[index][2]}");
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
                              Align(
                                alignment: Alignment.topCenter,
                                child: Image(
                                  image: AssetImage(
                                      "assets/images/meteoIcones/${MaxMinDay[index][3]}"),
                                  width: 24,
                                ),
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
            ),
          ),
        ),
      ],
    );
  }
}
