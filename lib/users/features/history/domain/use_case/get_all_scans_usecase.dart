import '../entities/history_scan.dart';
import '../repositories/history_repository.dart';

class GetAllScansUseCase {
  final HistoryRepository repository;

  GetAllScansUseCase(this.repository);

  Future<List<HistoryScan>> call() {
    return repository.getAllScans();
  }
}
