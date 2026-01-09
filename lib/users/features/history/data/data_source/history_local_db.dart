import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HistoryLocalDb {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), "history.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE scans (
  id TEXT PRIMARY KEY,
  imagePath TEXT,
  predictions TEXT, 
  createdAt TEXT
)

        ''');
      },
    );
  }

  // =============================================
  // ================ CRUD METHOD ================
  // =============================================

  /// Insert Scan
  Future<int> insertScan(Map<String, dynamic> data) async {
    final db = await database;
    return db.insert('scans', data);
  }

  /// Get All Scans
  Future<List<Map<String, dynamic>>> getAllScans() async {
    final db = await database;
    return db.query('scans', orderBy: "createdAt DESC");
  }

  /// Get Scan by ID
  Future<Map<String, dynamic>?> getScanById(String id) async {
    final db = await database;
    final result = await db.query(
      'scans',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return result.isNotEmpty ? result.first : null;
  }

  /// Delete Scan
  Future<int> deleteScan(String id) async {
    final db = await database;
    return db.delete(
      'scans',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}