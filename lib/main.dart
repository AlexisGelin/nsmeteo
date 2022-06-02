import 'package:flutter/material.dart';
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
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ///
            //////////////////////// Header
            ///
            ////// Nom de ville
            ///

            Text("Lyon", style: Theme.of(context).textTheme.titleMedium),

            ////// Température
            ///

            Text("26°", style: Theme.of(context).textTheme.titleLarge),

            ////// Température min et max
            ///

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Min. 24°", style: Theme.of(context).textTheme.titleSmall),
                const BlockSmall(),
                Text("Max. 32°", style: Theme.of(context).textTheme.titleSmall),
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
                  color: Theme.of(context).colorScheme.secondaryContainer,
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
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                child: ListTile(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
