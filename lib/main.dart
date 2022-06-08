import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nsmeteo/models/cityModel.dart';
import 'package:nsmeteo/widgets/CurrentPageBuilder.dart';

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
      debugShowCheckedModeBanner: false,
      theme: buildTheme(context),
      initialRoute: '/ville',
      routes: {
        '/ville': (context) => const AllCitySlider(),
        '/menu': (context) => const SecondScreen(),
      },
    );
  }
}

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
            BlockSmall(),
            Text("NSMétéo", style: Theme.of(context).textTheme.titleMedium),
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
            ListTile(),
          ],
        ),
      ),
    );
  }
}

final List<cityModel> cityList = [
  cityModel("lyon", 45.7578137, 4.8320114, "FR"),
  cityModel("Marseille", 43.2961743, 5.3699525, "FR"),
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
    bool enable;
    if (cityList.length < 2) {
      enable = false;
    } else {
      enable = true;
    }
    return Scaffold(
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: enable,
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
            ),
            items: cityList
                .map((item) => CurrentPageBuilder(
                      city: item,
                    ))
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
