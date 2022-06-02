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
                  contry varchar(255) not null
              );
          ''');
    });
    return db;
  }

  static Future<List<Map>> getDB(Database db) async {
    List<Map> list = await db.rawQuery('SELECT * FROM City');
    return list;
  }

  static Future<void> insertDB(Database db, String cityName) async {
    await db.transaction((txn) async {
      await txn.rawInsert('INSERT INTO City(name) VALUES(?)', [cityName]);
    });
  }

  static Future<void> deleteRecord(Database db, String city) async {
    await db.rawDelete('DELETE FROM City WHERE name = ?', [city]);
  }
}
