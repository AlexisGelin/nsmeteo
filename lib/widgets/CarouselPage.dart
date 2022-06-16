import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nsmeteo/widgets/ListCity.dart';
import 'package:nsmeteo/widgets/OnePageCarousel/CurrentPageBuilder.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nsmeteo/db/myDB.dart';
import '../models/cityModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarouselPage extends StatefulWidget {
  const CarouselPage({Key? key}) : super(key: key);

  @override
  State<CarouselPage> createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  int _selectedIndex = 0;
  int initPage = 0;

  void loadInitSlide() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      initPage = (prefs.getInt('indexPage') ?? 0);
    });
  }

  void saveIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('indexPage', index);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        _selectedIndex = 0;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ListCity()));
      }
    });
  }

  late Database db;
  List<cityModel> cityList = [];

  @override
  void initState() {
    super.initState();
    loadInitSlide();

    cityList = [];
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
    if (cityList.length < 2) {
    } else {
    }
    return Scaffold(
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: false,
              initialPage: initPage,
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  saveIndex(index);
                });
              },
            ),
            items:
                cityList.map((item) => CurrentPageBuilder(city: item)).toList(),
          );
        },
      ),
      bottomNavigationBar: _BuildBottomNavBar(context),
    );
  }

  // ignore: non_constant_identifier_names
  Container _BuildBottomNavBar(BuildContext context) {
    return Container(
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
    );
  }
}
