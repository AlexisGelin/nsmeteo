import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nsmeteo/models/cityModel.dart';
import 'package:nsmeteo/widgets/CarouselPage.dart';
import 'package:nsmeteo/widgets/CurrentPageBuilder.dart';
import 'package:nsmeteo/utils/appTheme.dart';
import 'package:nsmeteo/widgets/Block.dart';
import 'package:nsmeteo/widgets/CurrentWeatherBuilderList.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nsmeteo/db/myDB.dart';
import 'package:nsmeteo/services/geoCodingService.dart';

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

  var _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      db = await myDB.initDatabase();
      myDB.insertDB(db, cityModel("lyon", 4.78, 4.78, "Zeuby", "zeuby"));
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const BlockSmall(),
            Text("NSMétéo", style: Theme.of(context).textTheme.titleLarge),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _controller,
                style: Theme.of(context).textTheme.labelSmall,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          geoCodingService
                              .getCityData(_controller.text)
                              .then((value) {
                            setState(() {
                              cityList = value;
                            });
                          });
                        });
                      },
                      icon: const Icon(Icons.search),
                    ),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onTertiary),
                    ),
                    labelText: 'Rechercher une ville',
                    labelStyle: Theme.of(context).textTheme.labelSmall),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: cityList.length,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (BuildContext context, int index) {
                    if (cityList.length > 0) {
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
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Text(cityList[index].name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                  const SizedBox(width: 5),
                                  Text(cityList[index].country,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Text(cityList[index].state,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  const SizedBox(width: 5),
                                  const SizedBox(width: 200),
                                  // CurrentWeatherBuilderList(
                                  //   city: cityList[index],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Text("il n'y a pas de ville a afficher");
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
