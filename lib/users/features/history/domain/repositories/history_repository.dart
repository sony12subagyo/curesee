// import 'package:curesee/users/features/history/domain/entities/history_scan.dart';

// abstract class HistoryRepository {
//   Future<void> saveScan(HistoryScan scan);
//   Future<List<HistoryScan>> getAllScans();

//   // Tambahan baru:
//   Future<void> deleteScan(String id);
//   Future<HistoryScan?> getScan(String id);
// }


import '../entities/history_scan.dart';

abstract class HistoryRepository {
  Future<void> saveScan(HistoryScan scan);
  Future<List<HistoryScan>> getAllScans();
}
