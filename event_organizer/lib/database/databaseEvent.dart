import 'package:event_organizer/model/eventModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class databaseEvent {
  static final databaseEvent _instance = databaseEvent._internal();
  factory databaseEvent() => _instance;
  static Database? _database;

  databaseEvent._internal();

  Future<Database> _openDB() async {
    if (_database != null) return _database!;
    _database =
        await openDatabase(join(await getDatabasesPath(), 'database_event.db'),
            onCreate: (db, version) {
              return db.execute('''
            CREATE TABLE database_event(
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
            },
            version: 2,
            onUpgrade: (db, oldVersion, newVersion) async {
              if (oldVersion < 2) {
                await db.execute(
                    '''ALTER TABLE database_event ADD COLUMN maps TEXT''');
                await db.execute(
                    '''ALTER TABLE database_event ADD COLUMN invite INTEGER''');
                await db.execute(
                    '''ALTER TABLE database_event ADD COLUMN description TEXT''');
              }
            });
    return _database!;
  }

  Future<void> insertEvent(Event event) async {
    final db = await _openDB();
    await db.insert(
      'database_event',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Event>> getEvents() async {
    final db = await _openDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'database_event',
      orderBy: 'timestamp DESC',
    );
    return List.generate(
      maps.length,
      (i) {
        return Event.fromMap(maps[i]);
      },
    );
  }

  Future<bool> isEventCheckedIn(int eventId) async {
    final db = await _openDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'database_event',
      where: 'id = ?',
      whereArgs: [eventId],
    );
    return maps.isNotEmpty;
  }
}
