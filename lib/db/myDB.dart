import 'package:nsmeteo/models/cityModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class myDB {
  static Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'mydb.db');
    Database db = await openDatabase(path, version: 5,
        onCreate: (Database db, int version) async {
      await db.execute('''
            CREATE TABLE IF NOT EXISTS City( 
                  id primary key,
                  name varchar(255) not null,
                  lat integer not null,
                  lon integer not null,
                  country varchar(255) not null,
                  state varchar(255) not null
              );
          ''');
    });
    return db;
  }

  static Future<List<cityModel>> getDB(Database db) async {
    List<cityModel> cityList = [];
    List<Map> list = await db.rawQuery('SELECT * FROM City');
    list.forEach((element) {
      cityList.add(cityModel(element["name"], element["lat"], element["lon"],
          element["country"], element["state"]));
    });

    return cityList;
  }

  static Future<void> insertDB(Database db, cityModel City) async {
    await db.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO City(name, lat, lon, country, state) VALUES(?, ?, ?, ?, ?)',
          [City.name, City.lat, City.lon, City.country, City.state]);
    });
  }

  static Future<void> deleteRecord(Database db, cityModel city) async {
    await db.rawDelete('DELETE FROM City WHERE name = ?', [city.name]);
  }
}
