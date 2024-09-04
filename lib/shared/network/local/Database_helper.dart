import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? db;
  static const int version = 1;
  static const String tableName = 'favorites';

  static Future<void> initDb() async {
    if (db != null) {
      print('666666666666');
      return;
    } else {
      try {
        var path = '${await getDatabasesPath()}/favorites.db';
        db = await openDatabase(path, version: version,
            onCreate: (Database db, int version) async {
              print('Creating a new database');
              await db.execute(
                  '''
                  CREATE TABLE $tableName (
                    id INTEGER PRIMARY KEY AUTOINCREMENT, 
                    title STRING,
                    `index` INTEGER,
                    isFavorite INTEGER DEFAULT 0
                  )
                  ''');
            });
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<int?> insert(String title, int index) async {
    try {
      Map<String, Object?> data = {'title': title, 'index': index, 'isFavorite': 0};
      return await db!.insert(tableName, data);
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<int> delete(String title) async {
    return await db!.delete(tableName, where: 'title = ?', whereArgs: [title]);
  }

  static Future<int> deleteALL() async {
    print('delete');
    return await db!.delete(tableName);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    try {
      return await db!.query(tableName);
    } catch (e) {
      print(e);
    }
    return [];
  }

  static Future<int> updateFavorite(String title, int isFavorite) async {
    try {
      return await db!.update(
        tableName,
        {'isFavorite': isFavorite},
        where: 'title = ?',
        whereArgs: [title],
      );
    } catch (e) {
      print(e);
    }
    return 0;
  }

  static Future<List<Map<String, dynamic>>> getAllFavorites() async {
    try {
      return await db!.query(tableName, where: 'isFavorite = ?', whereArgs: [1]);
    } catch (e) {
      print(e);
    }
    return [];
  }

  static Future<List<String>> getAllFavoriteTitles() async {
    try {
      final List<Map<String, dynamic>> results = await db!.query(
        tableName,
        columns: ['title'], // Specify the 'title' column
        where: 'isFavorite = ?',
        whereArgs: [1],
      );

      // Extract titles from the result
      return results.map((row) => row['title'] as String).toList();
    } catch (e) {
      print(e);
    }
    return [];
  }


  static Future<bool> isItemFavorite(String title) async {
    try {
      var result = await db!.query(tableName,
          where: 'title = ? AND isFavorite = ?', whereArgs: [title, 1]);
      return result.isNotEmpty;
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    try {
      return await db!.query(tableName);
    } catch (e) {
      print(e);
    }
    return [];
  }
}
