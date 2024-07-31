import 'package:event_organizer/model/eventModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseBookmark {
  static final DatabaseBookmark instance = DatabaseBookmark._init();
  static Database? _database;

  DatabaseBookmark._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bookmark.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path,
        version: 2, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE bookmarks (
      id INTEGER PRIMARY KEY,
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

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _migrateOldData(db);
    }
  }

  Future<void> _migrateOldData(Database db) async {
    await db.execute('''
    CREATE TABLE new_bookmarks (
      id INTEGER PRIMARY KEY,
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

    // Copy data from old table to new table
    await db.execute('''
    INSERT INTO new_bookmarks (id, organizer, imageUrl, nameEvent, description, date, time, location, maps, price, status, invite)
    SELECT id, organizer, imageUrl, nameEvent, description, date, time, location, maps, price, status, invite FROM bookmarks
  ''');

    // Drop old table and rename new table
    await db.execute('DROP TABLE bookmarks');
    await db.execute('ALTER TABLE new_bookmarks RENAME TO bookmarks');
  }

  Future<void> addBookmark(Event event) async {
    final db = await instance.database;
    await db.insert('bookmarks', event.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeBookmark(int id) async {
    final db = await instance.database;
    await db.delete('bookmarks', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Event>> readAllBookmarkedEvents() async {
    final db = await instance.database;
    final maps = await db.query('bookmarks');
    return List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });
  }
}
