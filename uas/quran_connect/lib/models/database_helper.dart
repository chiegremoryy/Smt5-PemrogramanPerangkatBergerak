// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._init();
//   static Database? _database;

//   DatabaseHelper._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB('favorites.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);
//     return openDatabase(path, version: 1, onCreate: _onCreate);
//   }

//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE favorites(
//         ayahNumber INTEGER PRIMARY KEY
//       )
//     ''');
//   }

//   Future<void> insertFavorite(int ayahNumber) async {
//     final db = await instance.database;
//     await db.insert('favorites', {'ayahNumber': ayahNumber},
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<void> removeFavorite(int ayahNumber) async {
//     final db = await instance.database;
//     await db
//         .delete('favorites', where: 'ayahNumber = ?', whereArgs: [ayahNumber]);
//   }

//   Future<List<int>> getFavorites() async {
//     final db = await instance.database;
//     final result = await db.query('favorites');
//     return result.map((e) => e['ayahNumber'] as int).toList();
//   }
// }
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:quran_connect/models/favorite_ayah.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorites.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites(
        ayahNumber INTEGER PRIMARY KEY,
        surahNumber INTEGER,
        arabicText TEXT,
        translation TEXT
      )
    ''');
  }

  Future<void> insertFavorite(FavoriteAyah favoriteAyah) async {
    final db = await instance.database;
    await db.insert('favorites', favoriteAyah.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeFavorite(int ayahNumber) async {
    final db = await instance.database;
    await db
        .delete('favorites', where: 'ayahNumber = ?', whereArgs: [ayahNumber]);
  }

  Future<List<FavoriteAyah>> getFavorites() async {
    final db = await instance.database;
    final result = await db.query('favorites');
    return result.map((e) => FavoriteAyah.fromMap(e)).toList();
  }
}
