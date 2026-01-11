import '../entities/history_scan.dart';
import '../repositories/history_repository.dart';

class GetScanUseCase {
  final HistoryRepository repository;

  GetScanUseCase(this.repository);

  Future<HistoryScan?> call(String id) {
    return repository.getScan(id);
  }
}
