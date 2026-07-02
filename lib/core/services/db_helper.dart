import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:location_tracker/modules/location_tracker/data/models/location_model.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  factory DBHelper() {
    return _instance;
  }

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final pathString = join(dbPath, 'location_tracker.db');

    return await openDatabase(
      pathString,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE locations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        timestamp TEXT NOT NULL,
        accuracy REAL NOT NULL,
        session_id TEXT NOT NULL
      )
    ''');
  }

  // Insert location
  Future<int> insertLocation(LocationModel location) async {
    final db = await database;
    return await db.insert(
      'locations',
      location.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all locations, sorted by timestamp descending
  Future<List<LocationModel>> getAllLocations() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'locations',
      orderBy: 'timestamp DESC',
    );
    return List.generate(maps.length, (i) => LocationModel.fromJson(maps[i]));
  }

  // Get locations for a specific session
  Future<List<LocationModel>> getLocationsForSession(String sessionId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'locations',
      where: 'session_id = ?',
      whereArgs: [sessionId],
      orderBy: 'timestamp ASC',
    );
    return List.generate(maps.length, (i) => LocationModel.fromJson(maps[i]));
  }

  // Get list of distinct sessions with their start timestamps and count of points
  Future<List<Map<String, dynamic>>> getSessionsList() async {
    final db = await database;
    // We group by session_id and find the earliest timestamp as the start of the session
    return await db.rawQuery('''
      SELECT session_id, MIN(timestamp) as start_time, COUNT(id) as point_count
      FROM locations
      GROUP BY session_id
      ORDER BY start_time DESC
    ''');
  }

  // Delete a session
  Future<int> deleteSession(String sessionId) async {
    final db = await database;
    return await db.delete(
      'locations',
      where: 'session_id = ?',
      whereArgs: [sessionId],
    );
  }

  // Clear all locations
  Future<int> clearAllLocations() async {
    final db = await database;
    return await db.delete('locations');
  }
}
