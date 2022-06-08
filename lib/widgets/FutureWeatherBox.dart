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
        _BuildPrevisionsHeureParHeure(context),
        _BuildPrevisionSurCinqJours(context),
        _BuildVisibiliteAndPression(context),
        _BuildLeverAndCoucher(context),
      ],
    );
  }

  Padding _BuildLeverAndCoucher(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _BuildLever(context),
            const BlockSmall(),
            _BuildCoucher(context),
          ],
        ),
      );
  }

  Padding _BuildVisibiliteAndPression(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _BuildVisibilite(context),
            const BlockSmall(),
            _BuildPression(context),
          ],
        ),
      );
  }

  Padding _BuildPrevisionsHeureParHeure(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 174,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.access_time,
                              size: 18,
                              color:
                                  Theme.of(context).colorScheme.onTertiary),
                        ),
                        TextSpan(
                          text: " Prévisions heure par heure",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 110,
                  // decoration: BoxDecoration(
                  //   border: Border(
                  //     top: BorderSide(
                  //         width: 1,
                  //         color: Theme.of(context).colorScheme.tertiary),
                  //   ),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        String dtt;
                        if (DateTime.parse(
                                    "${fWeatherData.list![index].dtTxt}")
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
                                      "assets/images/meteoIcones/${icons}.png"),
                                  width: 24,
                                ),
                              ),
                              const BlockSmall(),
                              Text(
                                "${fWeatherData.list![index].main!.temp!.round()} °",
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: 9,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  Padding _BuildPrevisionSurCinqJours(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: SizedBox(
            height: 310,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.calendar_month,
                                size: 18,
                                color:
                                    Theme.of(context).colorScheme.onTertiary),
                          ),
                          TextSpan(
                            text: " Prévisions sur 5 jours",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
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
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        width: 1,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          txt,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                      const BlockSmall(),
                                      const BlockSmall(),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/meteoIcones/${MaxMinDay[index][3]}.png"),
                                          width: 24,
                                        ),
                                      ),
                                      const BlockSmall(),
                                      const BlockSmall(),
                                      const BlockSmall(),
                                      const BlockSmall(),
                                      SizedBox(
                                        width: 35,
                                        child: Text(
                                          "${MaxMinDay[index][0]} °",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                      const BlockSmall(),
                                      const BlockSmall(),
                                      Text(
                                        "${MaxMinDay[index][1]} °",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: MaxMinDay.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }

  Container _BuildVisibilite(BuildContext context) {
    return Container(
              height: 105,
              width: MediaQuery.of(context).size.width / 2.23,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.remove_red_eye,
                                    size: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary),
                              ),
                              TextSpan(
                                text: " Visibilité",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "1012m",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ),
            );
  }

  Container _BuildPression(BuildContext context) {
    return Container(
              height: 105,
              width: MediaQuery.of(context).size.width / 2.23,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.monitor_heart_rounded,
                                    size: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary),
                              ),
                              TextSpan(
                                text: " Pression",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "1013" + " hPa",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ),
            );
  }

  Container _BuildCoucher(BuildContext context) {
    return Container(
              height: 105,
              width: MediaQuery.of(context).size.width / 2.23,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.south_rounded,
                                    size: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary),
                              ),
                              TextSpan(
                                text: " Coucher",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "13 h",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ),
            );
  }

  Container _BuildLever(BuildContext context) {
    return Container(
              height: 105,
              width: MediaQuery.of(context).size.width / 2.23,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.north,
                                    size: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary),
                              ),
                              TextSpan(
                                text: " Lever",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "12" + " h",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ),
            );
  }
}
