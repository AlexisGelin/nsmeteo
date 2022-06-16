

import 'package:flutter/material.dart';
import 'package:nsmeteo/db/myDB.dart';
import 'package:nsmeteo/models/cityModel.dart';
import 'package:nsmeteo/models/Meteo.dart';
import 'package:nsmeteo/services/meteoService.dart';
import 'package:nsmeteo/widgets/ListCity.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/Ui.dart';
import 'CarouselPage.dart';
import 'OnePageCarousel/Builder/CurrentWeatherBuilder.dart';
import 'OnePageCarousel/Builder/CurrentWeatherBuilderMoreInfo.dart';
import 'OnePageCarousel/Builder/FutureWeatherBuilder.dart';

class SelectPageBuilder extends StatefulWidget {
  final cityModel city;
  final Database db;
  const SelectPageBuilder({Key? key, required this.city, required this.db})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<SelectPageBuilder> createState() => SelectPageBuilderState(city, db);
}

class SelectPageBuilderState extends State<SelectPageBuilder> {
  cityModel city;
  Database db;
  SelectPageBuilderState(this.city, this.db);
  late final Future<CurrentWeatherData> cW;

  @override
  void initState() {
    cW = meteoService.requestCurrentMeteoDataByGeoLoc(city, "metric");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CurrentWeatherData>(
      future: cW,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  textColor: Colors.white,
                  onPressed: () {
                    myDB.insertDB(db, city);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CarouselPage()));
                  },
                  shape:
                      const CircleBorder(side: BorderSide(color: Colors.transparent)),
                  child: const Text("Ajouter"),
                ),
              ],
              backgroundColor: Theme.of(context).colorScheme.secondary,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 255, 255, 255)),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListCity())),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/background/${UiUtils.getBackground("${snapshot.data!.weather![0].id}")}"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView(
                children: <Widget>[
                  CurrentWeatherBuilder(city: city),
                  FutureWeatherBuilder(city: city),
                  CurrentWeatherBuilderMoreInfo(city: city),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
