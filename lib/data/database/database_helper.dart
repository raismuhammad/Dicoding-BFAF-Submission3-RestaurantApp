import 'package:path/path.dart';
import 'package:restaurant_app/data/model/favorite.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database _database;
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }
  
  static const String _tableName = 'favorites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase('$path/favorites.db', 
    onCreate: (db, version) async {
      await db.execute(
        '''CREATE TABLE $_tableName (
        id TEXT,
        name TEXT, pictureId TEXT
        )''',
      );
    }, version: 3);
    return db;
  }

  Future<void> insertFavorite(Favorites favorites) async {
    final Database db = await database;
    await db.insert(_tableName, favorites.toMap());
  }

  Future<List<Favorites>> getFavorites() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);
    return results.map((res) => Favorites.fromMap(res)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db!.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }

  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}