// import 'package:curesee/users/features/history/domain/entities/history_scan.dart';
// import 'package:curesee/users/features/history/domain/repositories/history_repository.dart';

// class GetAllScansUseCase {
//   final HistoryRepository repository;

//   GetAllScansUseCase(this.repository);

//   Future<List<HistoryScan>> execute() {
//     return repository.getAllScans();
//   }
// }

import '../entities/history_scan.dart';
import '../repositories/history_repository.dart';

class GetAllScansUseCase {
  final HistoryRepository repository;

  GetAllScansUseCase(this.repository);

  Future<List<HistoryScan>> execute() {
    return repository.getAllScans();
  }
}

