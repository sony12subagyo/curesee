// import 'package:curesee/users/features/history/domain/entities/history_scan.dart';
// import 'package:curesee/users/features/history/domain/repositories/history_repository.dart';

// class SaveScanUseCase {
//   final HistoryRepository repository;

//   SaveScanUseCase(this.repository);

//   Future<void> execute(HistoryScan scan) {
//     return repository.saveScan(scan);
//   }
// }

import '../entities/history_scan.dart';
import '../repositories/history_repository.dart';

class SaveScanUseCase {
  final HistoryRepository repository;

  SaveScanUseCase(this.repository);

  Future<void> execute(HistoryScan scan) {
    return repository.saveScan(scan);
  }
}
