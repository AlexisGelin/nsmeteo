import 'package:flutter/material.dart';
import 'package:nsmeteo/utils/appTheme.dart';
import 'package:nsmeteo/widgets/CarouselPage.dart';
import 'package:nsmeteo/widgets/ListCity.dart';

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
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const CarouselPage(),
          ));
    });

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 39, 39),
      body: Center(
          child: Column(
        children: const [
          Text(
            "n",
            style: TextStyle(
                fontSize: 350,
                color: Color.fromARGB(255, 255, 255, 255),
                shadows: [
                  Shadow(
                      offset: Offset(-1, -1),
                      color: Color.fromARGB(255, 0, 0, 0)),
                  Shadow(
                      offset: Offset(1, -1),
                      color: Color.fromARGB(255, 0, 0, 0)),
                  Shadow(
                      offset: Offset(1, 1),
                      color: Color.fromARGB(255, 0, 0, 0)),
                  Shadow(
                      offset: Offset(-1, 1),
                      color: Color.fromARGB(255, 0, 0, 0)),
                ]),
          ),
          CircularProgressIndicator(
            color: Color.fromARGB(255, 54, 0, 201),
            backgroundColor: Color.fromARGB(255, 219, 219, 219),
          ),
        ],
      )),
    );
  }
}
