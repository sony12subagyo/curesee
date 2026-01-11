import '../entities/history_scan.dart';
import '../repositories/history_repository.dart';

class SaveScanUseCase {
  final HistoryRepository repository;

  SaveScanUseCase(this.repository);

  Future<void> call(HistoryScan scan) {
    return repository.saveScan(scan);
  }
}
