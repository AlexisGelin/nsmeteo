import 'package:flutter/material.dart';
import 'package:nsmeteo/db/myDB.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
  late Database db;
  List<Map> list = [];
  final controll = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      db = await myDB.initDatabase();
      // await myDB.insertDB(db, "lyon");
      // await myDB.insertDB(db, "paris");
      // await myDB.insertDB(db, "marseille");
      // await myDB.insertDB(db, "nice");
      // await myDB.insertDB(db, "bordeaux");
      // await myDB.deleteRecord(db, "lyon");
      // await myDB.deleteRecord(db, "paris");
      // await myDB.deleteRecord(db, "marseille");
      // await myDB.deleteRecord(db, "nice");
      // await myDB.deleteRecord(db, "bordeaux");

      myDB.getDB(db).then((value) {
        setState(() {
          list = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Column(
          children: [
            TextField(
              controller: controll,
            ),
            ElevatedButton(
                child: const Text("City"),
                onPressed: () {
                  setState(() {
                    myDB.insertDB(db, controll.text);
                    myDB.getDB(db).then((value) {
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
                    list[index]["name"],
                    style: const TextStyle(fontSize: 25),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          myDB.deleteRecord(db, list[index]["name"]);
                          myDB.getDB(db).then((value) {
                            setState(() {
                              list = value;
                            });
                          });
                        });
                      },
                      icon: const Icon(Icons.delete))
                ]));
              },
              itemCount: list.length,
            ),
          ],
        )));
  }
}
