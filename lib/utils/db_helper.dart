import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    String sql = "CREATE TABLE 'user_favorite_quotes'(id TEXT PRIMARY KEY, content TEXT)";
    return openDatabase(
      join(await getDatabasesPath(), 'quotes_database.db'),
      onCreate: (db, version) {
        return db.execute(sql);
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    db.insert(
        table,
        data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> getQuoteById(String id) async {
    final db = await DBHelper.database();
    final result = db.query(
      'user_favorite_quotes',
      where: "id = ?",
      whereArgs: [id]
    );
    return result;
  }

  static Future<dynamic> deleteFavoriteQuote(String id) async {
    final db = await DBHelper.database();
    final result = await db.delete(
      'user_favorite_quotes',
        where: "id = ?",
        whereArgs: [id],
    );
    return result;
  }
}