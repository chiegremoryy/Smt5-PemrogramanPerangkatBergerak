import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'databasev1.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            isCompleted INTEGER NOT NULL DEFAULT 0
          )
          ''',
        );
      },
    );
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return maps.map((map) => Task.fromMap(map)).toList();
  }

  Future<int> addTask(Task task) async {
    final db = await database;
    try {
      return await db.insert('tasks', task.toMap());
    } catch (e) {
      print('Error adding task: $e');
      throw Exception('Failed to add task.');
    }
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    try {
      return await db.update(
        'tasks',
        task.toMap(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    } catch (e) {
      print('Error updating task: $e');
      throw Exception('Failed to update task.');
    }
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    try {
      return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting task: $e');
      throw Exception('Failed to delete task.');
    }
  }
}
