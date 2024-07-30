import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:event_organizer/model/eventModel.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('events.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE events(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      organizer TEXT,
      imageUrl TEXT,
      nameEvent TEXT,
      description TEXT,
      date TEXT,
      time TEXT,
      location TEXT,
      maps TEXT,
      price TEXT,
      status TEXT,
      invite INTEGER
      )
      ''');
  }

  Future<int> create(Event event) async {
    final db = await instance.database;
    return await db.insert('events', event.toMap());
  }

  Future<List<Event>> readAllEvents() async {
    final db = await instance.database;
    final orderBy = 'date ASC';
    final result = await db.query('events', orderBy: orderBy);

    return result.map((json) => Event.fromMap(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
