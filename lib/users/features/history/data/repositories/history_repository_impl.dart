// import 'package:curesee/users/features/history/data/data_source/history_local_db.dart';
// import 'package:curesee/users/features/history/domain/entities/history_scan.dart';
// import 'package:curesee/users/features/history/domain/repositories/history_repository.dart';
// import 'package:sqflite/sqflite.dart';
// import '../models/history_scan_model.dart';

// class HistoryRepositoryImpl implements HistoryRepository {
//   final HistoryLocalDb localDb;

//   HistoryRepositoryImpl(this.localDb);

//   @override
//   Future<void> saveScan(HistoryScan scan) async {
//     final db = await localDb.database;

//     final model = HistoryScanModel(
//       id: scan.id,
//       imagePath: scan.imagePath,
//       predictions: scan.predictions,
//       createdAt: scan.createdAt,
//     );

//     await db.insert(
//       'scans',
//       model.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   @override
//   Future<List<HistoryScan>> getAllScans() async {
//     final db = await localDb.database;

//     final result = await db.query('scans', orderBy: "createdAt DESC");

//     return result.map((e) => HistoryScanModel.fromMap(e)).toList();
//   }

//   @override
//   Future<void> deleteScan(String id) async {
//     final db = await localDb.database;

//     await db.delete('scans', where: "id = ?", whereArgs: [id]);
//   }

//   @override
//   Future<HistoryScan?> getScan(String id) async {
//     final db = await localDb.database;

//     final result = await db.query('scans', where: "id = ?", whereArgs: [id]);

//     if (result.isEmpty) return null;

//     return HistoryScanModel.fromMap(result.first);
//   }
// }


import 'package:curesee/users/features/history/data/data_source/history_local_db.dart';
import '../../domain/entities/history_scan.dart';
import '../../domain/repositories/history_repository.dart';
import '../models/history_scan_model.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryLocalDb localDb;

  HistoryRepositoryImpl(this.localDb);

  @override
  Future<void> saveScan(HistoryScan scan) async {
    final db = await localDb.database;
    final model = HistoryScanModel(
      id: scan.id,
      imagePath: scan.imagePath,
      label: scan.label,
      confidence: scan.confidence,
      createdAt: scan.createdAt,
    );

    await db.insert('scans', model.toMap());
  }

  @override
  Future<List<HistoryScan>> getAllScans() async {
    final db = await localDb.database;
    final result = await db.query('scans', orderBy: "createdAt DESC");

    return result.map((e) => HistoryScanModel.fromMap(e)).toList();
  }
}
