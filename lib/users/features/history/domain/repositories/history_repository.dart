

import '../entities/history_scan.dart';

abstract class HistoryRepository {
  /// Simpan hasil scan ke local db
  Future<void> saveScan(HistoryScan scan);

  /// Ambil semua history scan
  Future<List<HistoryScan>> getAllScans();
  Future<HistoryScan?> getScan(String id);

  Future<void> deleteScan(String id);
}
