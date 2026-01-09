// import 'package:curesee/users/features/history/domain/entities/history_scan.dart';

// abstract class HistoryEvent {}

// // === EVENT UNTUK SAVE ===
// class SaveScanEvent extends HistoryEvent {
//   final HistoryScan scan;
//   SaveScanEvent(this.scan);
// }

// // === EVENT UNTUK LOAD LIST HISTORY ===
// class LoadHistoryEvent extends HistoryEvent {}

// // === EVENT UNTUK DELETE (BARU) ===
// class DeleteScanEvent extends HistoryEvent {
//   final String id;
//   DeleteScanEvent(this.id);
// }

// // === EVENT UNTUK LOAD DETAIL (BARU) ===
// class LoadDetailScanEvent extends HistoryEvent {
//   final String id;
//   LoadDetailScanEvent(this.id);
// }
part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadHistoryEvent extends HistoryEvent {}

class DeleteScanEvent extends HistoryEvent {
  final String id;
  DeleteScanEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class LoadDetailScanEvent extends HistoryEvent {
  final String id;
  LoadDetailScanEvent(this.id);

  @override
  List<Object?> get props => [id];
}