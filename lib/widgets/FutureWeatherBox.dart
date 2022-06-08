import 'package:flutter/material.dart';
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
        _BuildPrevisionSurPlusieursJours(context),
        _BuildVisibiliteAndPression(context),
        _BuildLeverAndCoucher(context),
        _BuildHumiditeAndRessenti(context),
        _BuildVent(context),
        BlockSmall(),
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
            mainAxisAlignment: MainAxisAlignment.center,
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
                            color: Theme.of(context).colorScheme.onTertiary),
                      ),
                      TextSpan(
                        text: " Prévisions heure par heure",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
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
                      double width = 50;


                      if (DateTime.parse("${fWeatherData.list![index].dtTxt}")
                              .hour <
                          10) {
                        dtt =
                            "0${DateTime.parse("${fWeatherData.list![index].dtTxt}").hour} h";
                      } else {
                        dtt =
                            "${DateTime.parse("${fWeatherData.list![index].dtTxt}").hour} h";
                      }

                      if(index == 0) {
                        dtt = "Maintenant";
                        width = 100;
                      }

                      String icons = UiUtils.getIcons(
                          "${fWeatherData.list![index].weather![0].id}");
                      return SizedBox(
                        width: width,
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            
                            Column(
                              children: [
                                Text(
                                  dtt,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const BlockSmall(),
                                Align(
                                  alignment: Alignment.center,
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
                                ),
                              ],
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

  Padding _BuildPrevisionSurPlusieursJours(BuildContext context) {
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
                              color: Theme.of(context).colorScheme.onTertiary),
                        ),
                        TextSpan(
                          text: " Prévisions sur les prochains jours",
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
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      child: Text(
                                        txt,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
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
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                    const BlockSmall(),
                                    const BlockSmall(),
                                    Text(
                                      "${MaxMinDay[index][1]} °",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
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
                            color: Theme.of(context).colorScheme.onTertiary),
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
                            color: Theme.of(context).colorScheme.onTertiary),
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
                        child: Icon(Icons.mode_night,
                            size: 18,
                            color: Theme.of(context).colorScheme.onTertiary),
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
                        child: Icon(Icons.sunny,
                            size: 18,
                            color: Theme.of(context).colorScheme.onTertiary),
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

  Padding _BuildVent(BuildContext context) {
    num dir = 220.5;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 205,
        width: MediaQuery.of(context).size.width,
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
                          child: Icon(Icons.wind_power,
                              size: 18,
                              color: Theme.of(context).colorScheme.onTertiary),
                        ),
                        TextSpan(
                          text: " Vent",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Column(
                        children: [
                          const Text("N"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("W"),
                              const BlockSmall(),
                              Column(
                                children: [
                                  const BlockSmall(),
                                  RotationTransition(
                                    turns: AlwaysStoppedAnimation(dir / 360),
                                    child: Icon(Icons.north,
                                        size: 42,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                  const BlockSmall(),
                                ],
                              ),
                              const BlockSmall(),
                              const Text("E"),
                            ],
                          ),
                          const Text("S"),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 5,
                      child: Column(
                        children: [
                          Text(
                            "12" + " kmh",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _BuildHumiditeAndRessenti(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _BuildHumidite(context),
          const BlockSmall(),
          _BuildRessenti(context),
        ],
      ),
    );
  }

  Container _BuildHumidite(BuildContext context) {
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
                        child: Icon(Icons.water,
                            size: 18,
                            color: Theme.of(context).colorScheme.onTertiary),
                      ),
                      TextSpan(
                        text: " Humidité",
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
                "95" + " %",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _BuildRessenti(BuildContext context) {
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
                        child: Icon(Icons.person,
                            size: 18,
                            color: Theme.of(context).colorScheme.onTertiary),
                      ),
                      TextSpan(
                        text: " Ressenti",
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
                "23" + " °",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
