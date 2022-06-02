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
      initialRoute: '/ville',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/ville': (context) => const OneCityScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/menu': (context) => const SecondScreen(),
      },
    );
  }
}

///
////// Page Une ville
///

class OneCityScreen extends StatefulWidget {
  const OneCityScreen({Key? key}) : super(key: key);

  @override
  State<OneCityScreen> createState() => _OneCityScreenState();
}

class _OneCityScreenState extends State<OneCityScreen> {
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
            ),

            ///
            //////////////////////// Bottom navbar
            ///
          ],
        ),
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
            BottomNavigationBarItem(icon: Icon(Icons.circle), label: 'A'),
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

///
////// Page Une ville
///

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
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                style: Theme.of(context).textTheme.labelSmall,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onTertiary)),
                    labelText: 'Rechercher une ville',
                    labelStyle: Theme.of(context).textTheme.labelSmall),
              ),
            ),

            ///
            ////// Liste des villes
            ///

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ville');
              },
              child: const Icon(Icons.search),
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
