import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class sql_helper{

  static Future<void> createTables(Database database) async {
    await database.execute("""Create Table items(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title TEXT,
    description TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)
    """);
  }
  static Future<Database> db() async  {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'demo.db');
    return openDatabase('first.db' , version: 1 , onCreate:(Database database, int version) async {
      await createTables(database);
    });

  }
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await sql_helper.db();
    return db.query('items' , orderBy: "id");
  }
}