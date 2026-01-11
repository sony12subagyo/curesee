import 'package:curesee/users/features/history/data/data_source/history_local_db.dart';
import 'package:curesee/users/features/history/data/data_source/history_remote_api.dart';
import 'package:curesee/users/features/history/data/models/history_scan_model.dart';
import 'package:curesee/users/features/history/domain/entities/history_scan.dart';
import 'package:curesee/users/features/history/domain/repositories/history_repository.dart';

  class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryLocalDb localDb;
  final HistoryRemoteApi remoteApi;

  HistoryRepositoryImpl(this.localDb, this.remoteApi);

  @override
Future<void> saveScan(HistoryScan scan) async {
  final model = HistoryScanModel.fromEntity(scan);

  final remote = await remoteApi.saveScan(
    imagePath: model.imagePath,
    label: model.predictions.first.label,
    confidence: model.predictions.first.confidence,
    firebaseUid: model.userId,
  );

  await localDb.insertScan(remote.toMap());
}


  @override
  Future<List<HistoryScan>> getAllScans() async {
    try {
      final remoteData = await remoteApi.getAllScans();

      for (final scan in remoteData) {
        await localDb.insertScan(scan.toMap());
      }

      return remoteData;
    } catch (_) {
      final local = await localDb.getAllScans();
      return local.map((e) => HistoryScanModel.fromMap(e)).toList();
    }
  }

  @override
  Future<HistoryScan?> getScan(String id) async {
    try {
      final remote = await remoteApi.getScan(id);
      await localDb.insertScan(remote.toMap());
      return remote;
    } catch (_) {
      final local = await localDb.getScan(id);
      if (local == null) return null;
      return HistoryScanModel.fromMap(local);
    }
  }

  @override
  Future<void> deleteScan(String id) async {
    await remoteApi.deleteScan(id);
    await localDb.deleteScan(id);
  }
}

