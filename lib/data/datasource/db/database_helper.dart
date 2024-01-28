import 'package:diresto/data/model/table_restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblFavorite = 'favorite';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/diresto.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tblFavorite (
        id TEXT PRIMARY KEY,
        pictureId TEXT,
        name TEXT,
        description TEXT,
        city TEXT,
        rating DOUBLE
      );
    ''');
  }

  Future<int> insertFavorite(TableRestaurant restaurant) async {
    final db = await database;
    return await db!.insert(_tblFavorite, restaurant.toJson());
  }

  Future<int> removeFavorite(TableRestaurant restaurant) async {
    final db = await database;
    return await db!.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [restaurant.id],
    );
  }

  Future<Map<String, dynamic>?> getRestaurarntById(String id) async {
    final db = await database;
    final results = await db!.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblFavorite);
    return results;
  }
}
