import 'package:flutter/material.dart';
import 'package:nsmeteo/models/cityModel.dart';
import 'package:nsmeteo/utils/UiColor.dart';
import 'package:nsmeteo/widgets/CurrentWeatherBuilder.dart';
import 'dart:ui';

import 'package:nsmeteo/widgets/FutureWeatherBuilder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: Column(
          children: [
            CurrentWeatherBuilder(city: cityModel("lyon", 45.7, 4.8, "FR")),
            FutureWeatherBuilder(city: cityModel("lyon", 45.7, 4.8, "FR")),
          ],
        ),
        backgroundColor: UiColor.HexaColor("#5FA8D3"));
  }
}


// cityModel("lyon", 45.7, 4.8, "FR")