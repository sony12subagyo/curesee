import '../../domain/entities/history_scan.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<HistoryScan> scans;
  HistoryLoaded(this.scans);
}

class HistoryDetailLoaded extends HistoryState {
  final HistoryScan scan;
  HistoryDetailLoaded(this.scan);
}

class HistoryError extends HistoryState {
  final String message;
  HistoryError(this.message);
}
