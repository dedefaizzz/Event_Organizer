import 'package:event_organizer/model/eventModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseOrder {
  static final DatabaseOrder _instance = DatabaseOrder._internal();
  factory DatabaseOrder() => _instance;
  static Database? _database;

  DatabaseOrder._internal();

  Future<Database> _openDB() async {
    if (_database != null) return _database!;
    _database = await openDatabase(
      join(await getDatabasesPath(), 'event_order.db'),
      version: 2,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableEvents(
            ${EventFields.id} INTEGER PRIMARY KEY,
            ${EventFields.organizer} TEXT,
            ${EventFields.imageUrl} TEXT,
            ${EventFields.nameEvent} TEXT,
            ${EventFields.description} TEXT,
            ${EventFields.date} TEXT,
            ${EventFields.time} TEXT,
            ${EventFields.location} TEXT,
            ${EventFields.maps} TEXT,
            ${EventFields.price} TEXT,
            ${EventFields.status} TEXT,
            ${EventFields.invite} INTEGER
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            ALTER TABLE $tableEvents ADD COLUMN ${EventFields.maps} TEXT NOT NULL DEFAULT "";
          ''');
          await db.execute('''
            ALTER TABLE $tableEvents ADD COLUMN ${EventFields.status} TEXT NOT NULL DEFAULT "";
          ''');
        }
      },
    );
    return _database!;
  }

  Future<void> insertEvent(Event event) async {
    final db = await _openDB();
    await db.insert(
      tableEvents,
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Event>> getOrderedEvents() async {
    final db = await _openDB();
    final List<Map<String, dynamic>> maps = await db.query(
      tableEvents,
      orderBy: '${EventFields.date} ASC',
    );
    return List.generate(
      maps.length,
      (i) {
        return Event.fromMap(maps[i]);
      },
    );
  }

  Future<bool> isEventOrdered(int eventId) async {
    final db = await _openDB();
    final List<Map<String, dynamic>> maps = await db.query(
      tableEvents,
      where: '${EventFields.id} = ?',
      whereArgs: [eventId],
    );
    return maps.isNotEmpty;
  }
}

const String tableEvents = 'events';

class EventFields {
  static final List<String> values = [
    id,
    organizer,
    imageUrl,
    nameEvent,
    description,
    date,
    time,
    location,
    maps,
    price,
    status,
    invite
  ];

  static const String id = 'id';
  static const String organizer = 'organizer';
  static const String imageUrl = 'imageUrl';
  static const String nameEvent = 'nameEvent';
  static const String description = 'description';
  static const String date = 'date';
  static const String time = 'time';
  static const String location = 'location';
  static const String maps = 'maps';
  static const String price = 'price';
  static const String status = 'status';
  static const String invite = 'invite';
}
