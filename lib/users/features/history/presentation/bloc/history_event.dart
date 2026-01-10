// part of 'history_bloc.dart';

// abstract class HistoryEvent extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class LoadHistoryEvent extends HistoryEvent {}

// class DeleteScanEvent extends HistoryEvent {
//   final String id;
//   DeleteScanEvent(this.id);

//   @override
//   List<Object?> get props => [id];
// }

// class LoadDetailScanEvent extends HistoryEvent {
//   final String id;
//   LoadDetailScanEvent(this.id);

//   @override
//   List<Object?> get props => [id];
// }

// class AddHistoryScanEvent extends HistoryEvent {
//   final HistoryScan scan;

//   AddHistoryScanEvent(this.scan);

//   @override
//   List<Object?> get props => [scan];
// }


// import 'package:curesee/users/features/history/domain/entities/history_scan.dart';
// import 'package:curesee/users/features/history/domain/use_case/get_all_scans_usecase.dart';
// import 'package:curesee/users/features/history/domain/use_case/save_scan_usecase.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// abstract class HistoryEvent {}

// class SaveScanEvent extends HistoryEvent {
//   final HistoryScan scan;
//   SaveScanEvent(this.scan);
// }

// class LoadHistoryEvent extends HistoryEvent {}

// abstract class HistoryState {}

// class HistoryInitial extends HistoryState {}
// class HistoryLoading extends HistoryState {}
// class HistoryLoaded extends HistoryState {
//   final List<HistoryScan> scans;
//   HistoryLoaded(this.scans);
// }
// class HistorySaving extends HistoryState {}
// class HistorySaved extends HistoryState {}
// class HistoryError extends HistoryState {
//   final String message;
//   HistoryError(this.message);
// }

// class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
//   final SaveScanUseCase saveScan;
//   final GetAllScansUseCase getAllScans;

//   HistoryBloc(this.saveScan, this.getAllScans) : super(HistoryInitial()) {
//     on<SaveScanEvent>((event, emit) async {
//       await saveScan.execute(event.scan);
//       add(LoadHistoryEvent());
//     });

//     on<LoadHistoryEvent>((event, emit) async {
//       emit(HistoryLoading());
//       try {
//         final data = await getAllScans.execute();
//         emit(HistoryLoaded(data));
//       } catch (e) {
//         emit(HistoryError(e.toString()));
//       }
//     });
//   }
// }