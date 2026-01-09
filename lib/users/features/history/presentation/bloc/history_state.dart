// import 'package:curesee/users/features/history/domain/entities/history_scan.dart';

// abstract class HistoryState {}

// // INITIAL
// class HistoryInitial extends HistoryState {}

// // LOADING
// class HistoryLoading extends HistoryState {}

// // LIST LOADED
// class HistoryLoaded extends HistoryState {
//   final List<HistoryScan> scans;
//   HistoryLoaded(this.scans);
// }

// // ERROR STATE
// class HistoryError extends HistoryState {
//   final String message;
//   HistoryError(this.message);
// }

// // SAVING
// class HistorySaving extends HistoryState {}

// // SAVED
// class HistorySaved extends HistoryState {}

// // === STATE BARU: DATA DETAIL ===
// class HistoryDetailLoaded extends HistoryState {
//   final HistoryScan scan;
//   HistoryDetailLoaded(this.scan);
// }

// // === STATE BARU: DELETE SUKSES ===
// class HistoryDeletedState extends HistoryState {
//   final String deletedId;

//   HistoryDeletedState(this.deletedId);
// }
part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoryLoadingState extends HistoryState {}

class HistoryLoadedState extends HistoryState {
  final List<HistoryScan> scans;
  HistoryLoadedState(this.scans);

  @override
  List<Object?> get props => [scans];
}

class HistoryDeletedState extends HistoryState {}
class HistoryDetailLoadedState extends HistoryState {
  final HistoryScan detail;
  HistoryDetailLoadedState(this.detail);
}

class HistoryDetailLoaded extends HistoryState {
  final HistoryScan detail;
  HistoryDetailLoaded(this.detail);

  @override
  List<Object?> get props => [detail];
}

class HistoryErrorState extends HistoryState {
  final String message;
  HistoryErrorState(this.message);

  @override
  List<Object?> get props => [message];
}