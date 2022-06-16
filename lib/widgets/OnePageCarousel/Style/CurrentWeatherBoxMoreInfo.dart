


import 'package:flutter/material.dart';
import 'package:nsmeteo/models/Meteo.dart';
import 'package:nsmeteo/utils/Block.dart';



class CurrentWeatherBoxMoreInfo extends StatefulWidget {
  final CurrentWeatherData cWeatherData;
  const CurrentWeatherBoxMoreInfo({Key? key, required this.cWeatherData})
      : super(key: key);

  @override
  State<CurrentWeatherBoxMoreInfo> createState() =>
      // ignore: no_logic_in_create_state
      CurrentWeatherBoxMoreInfoState(cWeatherData);
}




class CurrentWeatherBoxMoreInfoState extends State<CurrentWeatherBoxMoreInfo> {
  CurrentWeatherData cWeatherData;

  CurrentWeatherBoxMoreInfoState(this.cWeatherData);


  @override
  Widget build(BuildContext context) {

    
    return Column(
      children: [
              _BuildVisibiliteAndPression(context),
        _BuildLeverAndCoucher(context),
        _BuildHumiditeAndRessenti(context),
        _BuildVent(context),
        const BlockSmall(),
      ],
    );
  }

    // ignore: non_constant_identifier_names
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

 
 // ignore: non_constant_identifier_names
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
  // ignore: non_constant_identifier_names
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
                "${cWeatherData.visibility} m",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
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
                "${cWeatherData.main!.pressure}" " hPa",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
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
                "${DateTime.fromMillisecondsSinceEpoch(cWeatherData.sys!.sunset!.toInt()*1000).hour} h ${DateTime.fromMillisecondsSinceEpoch(cWeatherData.sys!.sunset!.toInt()*1000).minute} ${DateTime.fromMillisecondsSinceEpoch(cWeatherData.sys!.sunset!.toInt()*1000).timeZoneName}",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
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
                "${DateTime.fromMillisecondsSinceEpoch(cWeatherData.sys!.sunrise!.toInt()*1000).hour} h ${DateTime.fromMillisecondsSinceEpoch(cWeatherData.sys!.sunrise!.toInt()*1000).minute} ${DateTime.fromMillisecondsSinceEpoch(cWeatherData.sys!.sunrise!.toInt()*1000).timeZoneName}",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding _BuildVent(BuildContext context) {
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
                    child: SizedBox(
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
                                    turns: AlwaysStoppedAnimation(cWeatherData.wind!.deg!/360),
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
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 5,
                      child: Column(
                        children: [
                          Text(
                            "${cWeatherData.wind!.speed}" " kmh",
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

  // ignore: non_constant_identifier_names
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

  // ignore: non_constant_identifier_names
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
                "${cWeatherData.main!.humidity}" " %",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
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
                "${cWeatherData.main!.feelsLike!.round()}" " °",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
