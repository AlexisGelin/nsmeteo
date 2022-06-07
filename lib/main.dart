import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nsmeteo/models/cityModel.dart';
import 'package:nsmeteo/utils/UiColor.dart';
import 'package:nsmeteo/widgets/CurrentWeatherBuilder.dart';
import 'dart:ui';

import 'package:nsmeteo/widgets/FutureWeatherBuilder.dart';
import 'package:nsmeteo/utils/appTheme.dart';
import 'package:nsmeteo/widgets/Block.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildTheme(context),
      initialRoute: '/ville',
      routes: {
        '/ville': (context) => const AllCitySlider(),
        '/menu': (context) => const SecondScreen(),
      },
    );
  }
}

///
////// Page toutes les viles
///

var _controller = TextEditingController();

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

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
            ///
            //////////////////////// Header
            ///

            ///
            ////// Title
            ///
            BlockSmall(),

            Text("NSMétéo", style: Theme.of(context).textTheme.titleMedium),

            ///
            ////// SearchBar
            ///
            ///

            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _controller,
                style: Theme.of(context).textTheme.labelSmall,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: _controller.clear,
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

            ///
            ////// Liste des villes
            ///

            ListTile(),
          ],
        ),
      ),
    );
  }
}

final List<String> imgList = [
  'assets/images/background/thunder.gif',
  'assets/images/background/cloudy.gif',
  'assets/images/background/cloudysun.gif',
  'assets/images/background/rain.gif',
  'assets/images/background/snow.gif',
  'assets/images/background/sunny.gif',
];

class AllCitySlider extends StatefulWidget {
  const AllCitySlider({Key? key}) : super(key: key);

  @override
  State<AllCitySlider> createState() => _AllCitySlider();
}

class _AllCitySlider extends State<AllCitySlider> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 2) {
        _selectedIndex = 1;
        Navigator.pushNamed(context, '/menu');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              // autoPlay: false,
            ),
            items: imgList
                .map(
                  (item) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(item),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // color: Theme.of(context).colorScheme.background,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ///
                        //////////////////////// Header
                        ///
                        ////// Nom de ville
                        ///

                        Text("Lyon",
                            style: Theme.of(context).textTheme.titleMedium),

                        ////// Température
                        ///

                        Text("26°",
                            style: Theme.of(context).textTheme.titleLarge),

                        ////// Température min et max
                        ///

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Min. 24°",
                                style: Theme.of(context).textTheme.titleSmall),
                            const BlockSmall(),
                            Text("Max. 32°",
                                style: Theme.of(context).textTheme.titleSmall),
                          ],
                        ),

                        ///
                        //////////////////////// Température par heure
                        ///

                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                            child: ListTile(),
                          ),
                        ),

                        ///
                        //////////////////////// Température pour les 5 jours
                        ///

                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                            child: ListTile(),
                          ),
                        ),

                        ///
                        //////////////////////// Bottom navbar
                        ///
                      ],
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
            BottomNavigationBarItem(icon: Icon(Icons.circle), label: 'Lyon'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Liste'),
          ],
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.tertiary,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}


// cityModel("lyon", 45.7, 4.8, "FR")