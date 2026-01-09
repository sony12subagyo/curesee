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

class AddHistoryScanEvent extends HistoryEvent {
  final HistoryScan scan;

  AddHistoryScanEvent(this.scan);

  @override
  List<Object?> get props => [scan];
}
