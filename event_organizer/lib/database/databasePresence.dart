import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:event_organizer/model/presenceModel.dart';

class databasePresence {
  static final databasePresence _instance = databasePresence._internal();
  factory databasePresence() => _instance;
  static Database? _database;

  databasePresence._internal();

  Future<Database> _openDB() async {
    if (_database != null) return _database!;
    _database = await openDatabase(
      join(await getDatabasesPath(), 'presence.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE presence (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            eventId INTEGER,
            imagePath TEXT,
            latitude REAL,
            longitude REAL,
            timestamp TEXT
          )
          ''');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute('''ALTER TABLE presence ADD COLUMN eventId INTEGER''');
        }
      },
      version: 2,
    );
    return _database!;
  }

  Future<void> insertPresence(Presence presence) async {
    final db = await _openDB();
    await db.insert(
      'presence',
      presence.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<Presence>> getPresences(int eventId) async {
    final db = await _openDB();
    final List<Map<String, dynamic>> maps =
        await db.query('presence', where: 'eventId = ?', whereArgs: [eventId]);

    return List.generate(
      maps.length,
      (i) {
        return Presence.fromMap(maps[i]);
      },
    );
  }
}
