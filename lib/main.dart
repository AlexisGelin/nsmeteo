import 'package:flutter/material.dart';

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
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
            ///
            //////////////////////// Header
            ///

            Text("Météo",
                style: TextStyle(
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.bold,
                    fontSize: 32)),

            ///
            //////////////////////// Température par heure
            ///
            

            ///
            //////////////////////// Température pour les 5 jours
            ///
          ])),
    );
  }
}
