import 'package:flutter/material.dart';
import 'package:nsmeteo/models/cityModel.dart';

import 'package:nsmeteo/utils/appTheme.dart';
import 'package:nsmeteo/utils/Block.dart';
import 'package:nsmeteo/widgets/CarouselPage.dart';
import 'package:nsmeteo/widgets/SelectPageBuilde.dart';

import 'package:sqflite/sqflite.dart';
import 'package:nsmeteo/db/myDB.dart';
import 'package:nsmeteo/services/geoCodingService.dart';
import 'package:nsmeteo/services/meteoService.dart';
import 'models/Meteo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(context),
      initialRoute: '/ville',
      routes: {
        '/ville': (context) => const CarouselPage(),
        '/menu': (context) => const SecondScreen(),
      },
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late Database db;
  List<cityModel> cityList = [];
  List<cityModel> cityListApi = [];
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      db = await myDB.initDatabase();
      myDB.getDB(db).then((value) {
        setState(() {
          cityList = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CarouselPage())),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const BlockSmall(),
            Text("NSMétéo", style: Theme.of(context).textTheme.titleLarge),
            const BlockSmall(),
            _BuildSearchBar(context),

            // fait de ses 3 la une seul list avec des onglet genre Ville rechercher -> list Ville recament consulter -> list Vos Ville ->list
            _BuildMenuAllCityApi(),
            _BuildMenuAllCity(),
          ],
        ),
      ),
    );
  }

  Padding _BuildMenuAllCityApi() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: cityListApi.length,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (BuildContext context, int index) {
            if (cityListApi.length > 0) {
              ///Une ligne avec une ville
              return _BuildMenuOneCityApi(index, context);
            } else {
              return Text("il n'y a pas de ville a afficher");
            }
          },
        ),
      ),
    );
  }

  Padding _BuildMenuAllCity() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: cityList.length,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (BuildContext context, int index) {
            if (cityList.length > 0) {
              ///Une ligne avec une ville
              return _BuildMenuOneCity(index, context);
            } else {
              return Text("il n'y a pas de ville a afficher");
            }
          },
        ),
      ),
    );
  }

  Padding _BuildMenuOneCityApi(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SelectPageBuilder(city: cityListApi[index], db: db)));
        },
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: FutureBuilder<CurrentWeatherData>(
            future: meteoService.requestCurrentMeteoDataByGeoLoc(
                cityListApi[index], "metric"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(cityListApi[index].name,
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(width: 120),
                          const BlockSmall(),
                          Text("${snapshot.data!.main!.temp!.round()}°",
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                      Row(
                        children: [
                          Text(cityListApi[index].country,
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text(cityListApi[index].state,
                              style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(width: 110),
                          Text(
                              "Min. " +
                                  "${snapshot.data!.main!.tempMin!.round()}°",
                              style: Theme.of(context).textTheme.bodyMedium),
                          const BlockSmall(),
                          Text(
                              "Max. " +
                                  "${snapshot.data!.main!.tempMax!.round()}°",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ],
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Padding _BuildMenuOneCity(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: AlignmentDirectional.centerEnd,
          color: Colors.red,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
        key: ValueKey<cityModel>(cityList[index]),
        onDismissed: (DismissDirection direction) {
          setState(() {
            myDB.deleteRecord(db, cityList[index]);
            cityList.removeAt(index);
          });
        },
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SelectPageBuilder(city: cityList[index], db: db)));
          },
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: FutureBuilder<CurrentWeatherData>(
              future: meteoService.requestCurrentMeteoDataByGeoLoc(
                  cityList[index], "metric"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(cityList[index].name,
                                style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(width: 120),
                            const BlockSmall(),
                            Text("${snapshot.data!.main!.temp!.round()}°",
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                        Row(
                          children: [
                            Text(cityList[index].country,
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text(cityList[index].state,
                                style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(width: 110),
                            Text(
                                "Min. " +
                                    "${snapshot.data!.main!.tempMin!.round()}°",
                                style: Theme.of(context).textTheme.bodyMedium),
                            const BlockSmall(),
                            Text(
                                "Max. " +
                                    "${snapshot.data!.main!.tempMax!.round()}°",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }

  Padding _BuildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        controller: _controller,
        style: Theme.of(context).textTheme.labelSmall,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  geoCodingService.getCityData(_controller.text).then((value) {
                    setState(() {
                      cityListApi = value;
                    });
                  });
                });
              },
              icon: const Icon(Icons.search),
            ),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.onTertiary),
            ),
            labelText: 'Ajouter une ville',
            labelStyle: Theme.of(context).textTheme.labelSmall),
      ),
    );
  }
}
