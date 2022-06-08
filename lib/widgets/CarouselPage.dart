import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nsmeteo/widgets/CurrentPageBuilder.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nsmeteo/db/myDB.dart';
import '../models/cityModel.dart';

class CarouselPage extends StatefulWidget {
  const CarouselPage({Key? key}) : super(key: key);

  @override
  State<CarouselPage> createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        _selectedIndex = 0;
        Navigator.pushNamed(context, '/menu');
      }
    });
  }

  late Database db;
  List<cityModel> cityList = [];
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
            //BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
            BottomNavigationBarItem(icon: Icon(Icons.circle), label: 'Ville'),
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