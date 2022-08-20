import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DBQueries {
  static createDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'demo.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Users (id INTEGER PRIMARY KEY, name TEXT, total DOUBLE, last_activity TEXT,Last_activity_amount DOUBLE)');
    });
    insertQuery();
    // await deleteDatabase(path);
  }

  static insertQuery() async {
    Database database = await openDatabase('demo.db');
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Users(name, total, last_activity,Last_activity_amount) VALUES("karem", 100.0,"25/5" ,100.0)');
      print('inserted1: $id1');
      int id2 = await txn.rawInsert(
          'INSERT INTO Users(name, total, last_activity,Last_activity_amount) VALUES("hossam", 300.0,"26/9" ,200.0)');
      print('inserted2: $id2');
      int id3 = await txn.rawInsert(
          'INSERT INTO Users(name, total, last_activity,Last_activity_amount) VALUES("ibrahim", 500.0, "1/1",300.0)');
      print('inserted2: $id3');
    });
  }

  static insertUser(String name, double total, String lastActivity,
      double lastActivityAmount) async {
    Database database = await openDatabase('demo.db');
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Users(name, total, last_activity,Last_activity_amount) VALUES("$name", $total, $lastActivity,$lastActivityAmount)');
      print('inserted1: $id1');
    });
  }
}
