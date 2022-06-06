import 'package:nsmeteo/models/cityModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class myDB {
  static Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'bob.db');
    Database db = await openDatabase(path, version: 4,
        onCreate: (Database db, int version) async {
      await db.execute('''
            CREATE TABLE IF NOT EXISTS City( 
                  id primary key,
                  name varchar(255) not null,
                  lat integer not null,
                  lon integer not null,
                  country varchar(255) not null
              );
          ''');
    });
    return db;
  }

  static Future<List<Map>> getDB(Database db) async {
    List<Map> list = await db.rawQuery('SELECT * FROM City');
    return list;
  }

  static Future<void> insertDB(Database db, cityModel City) async {
    await db.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO City(name, lat, lon, country) VALUES(?, ?, ?, ?)',
          [City.name, City.lat, City.lon, City.country]);
    });
  }

  static Future<void> deleteRecord(Database db, String city) async {
    await db.rawDelete('DELETE FROM City WHERE name = ?', [city]);
  }
}
