import 'package:curesee/users/features/history/domain/entities/history_scan.dart';
import 'package:curesee/users/features/history/domain/repositories/history_repository.dart';

class GetScanDetailUseCase {
  final HistoryRepository repository;

  GetScanDetailUseCase(this.repository);

  Future<HistoryScan?> call (String id) {
    return repository.getScan(id);
  }
}