import 'package:flutter/material.dart';
import 'package:nsmeteo/models/cityModel.dart';
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
  List<cityModel> list = [];
  final controll = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: controll,
          ),
          ElevatedButton(
              child: const Text("City"),
              onPressed: () {
                setState(() {
                  geoCodingService.getCityData(controll.text).then((value) {
                    setState(() {
                      list = value;
                    });
                  });
                });
              }),

          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Container(
                  child: Column(children: [
                Text(
                  list[index].name,
                  style: const TextStyle(fontSize: 25),
                ),
                Text(
                  list[index].country,
                  style: const TextStyle(fontSize: 25),
                ),
                Text(
                  list[index].lat.toString(),
                  style: const TextStyle(fontSize: 25),
                ),
                Text(
                  list[index].lon.toString(),
                  style: const TextStyle(fontSize: 25),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        // list = value;
                        // myDB.deleteRecord(db, list[index]["name"]);
                        // myDB.getDB(db).then((value) {
                        //   setState(() {

                        //   });
                        // });
                      });
                    },
                    icon: const Icon(Icons.add))
              ]));
            },
            itemCount: list.length,
          ),

          // FutureBuilder<List<cityModel>>(
          //   future: geoCodingService.getCityData(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(
          //         child: Text("chargement en cours ..."),
          //       );
          //     } else if (snapshot.connectionState == ConnectionState.done) {
          //       return ListView.builder(
          //         itemCount: snapshot.data!.length,
          //         itemBuilder: (context, index) {
          //           return Column(
          //             children: [
          //               Text(snapshot.data![index].name),
          //               Text(snapshot.data![index].lat.toString()),
          //               Text(snapshot.data![index].lon.toString()),
          //               Text(snapshot.data![index].country),
          //             ],
          //           );
          //         },
          //       );
          //     } else {
          //       return const Text("Une erreur est survenue.");
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
