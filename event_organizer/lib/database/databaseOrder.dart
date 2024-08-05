import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:event_organizer/model/eventModel.dart';

class DatabaseOrder {
  static final DatabaseOrder instance = DatabaseOrder._init();
  static Database? _database;

  DatabaseOrder._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('event_order.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = join(await getDatabasesPath(), filePath);
    return await openDatabase(dbPath, version: 2, onCreate: _createDB);
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
          'ALTER TABLE $tableEvents ADD COLUMN ${EventFields.organizer} TEXT NOT NULL DEFAULT ""');
      await db.execute(
          'ALTER TABLE $tableEvents ADD COLUMN ${EventFields.status} TEXT NOT NULL DEFAULT ""');
    }
  }

  Future _createDB(Database db, int version) async {
    const String idType = 'TEXT PRIMARY KEY';
    const String textType = 'TEXT NOT NULL';
    const String integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $tableEvents (
      ${EventFields.id} $idType,
      ${EventFields.organizer} $textType,
      ${EventFields.imageUrl} $textType,
      ${EventFields.nameEvent} $textType,
      ${EventFields.description} $textType,
      ${EventFields.date} $textType,
      ${EventFields.time} $textType,
      ${EventFields.location} $textType,
      ${EventFields.maps} $textType,
      ${EventFields.price} $textType,
      ${EventFields.status} $textType,
      ${EventFields.invite} $integerType
    )
    ''');
  }

  Future<void> createEvent(Event event) async {
    final db = await instance.database;
    await db.insert(
      tableEvents,
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Event>> readAllEvents() async {
    final db = await instance.database;
    final orderBy = '${EventFields.date} ASC';
    final result = await db.query(tableEvents, orderBy: orderBy);
    return result.map((json) => Event.fromMap(json)).toList();
  }

  Future<bool> isEventOrdered(String id) async {
    final db = await instance.database;
    final result = await db.query(
      tableEvents,
      columns: [EventFields.id],
      where: '${EventFields.id} = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }

  Future<void> deleteEvent(String id) async {
    final db = await instance.database;
    await db.delete(
      tableEvents,
      where: '${EventFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

const String tableEvents = 'events';

class EventFields {
  static final List<String> values = [
    id,
    organizer,
    nameEvent,
    description,
    date,
    time,
    price,
    location,
    imageUrl,
    maps,
    status,
    invite
  ];

  static const String id = 'id';
  static const String organizer = 'organizer';
  static const String nameEvent = 'nameEvent';
  static const String description = 'description';
  static const String date = 'date';
  static const String time = 'time';
  static const String price = 'price';
  static const String location = 'location';
  static const String imageUrl = 'imageUrl';
  static const String maps = 'maps';
  static const String invite = 'invite';
  static const String status = 'status';
}
