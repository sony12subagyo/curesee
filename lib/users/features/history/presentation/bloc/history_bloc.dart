// import 'package:curesee/users/features/history/domain/use_case/delete_scan_usecase.dart';
// import 'package:curesee/users/features/history/domain/use_case/get_all_scans_usecase.dart';
// import 'package:curesee/users/features/history/domain/use_case/get_scan_usecase.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';

// import '../../domain/entities/history_scan.dart';

// part 'history_event.dart';
// part 'history_state.dart';

// class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
//   final GetAllScansUseCase getAllScansUseCase;
//   final GetScanDetailUseCase getScanDetailUseCase;
//   final DeleteScanUseCase deleteScanUseCase;

//   HistoryBloc({
//     required this.getAllScansUseCase,
//     required this.getScanDetailUseCase,
//     required this.deleteScanUseCase,
//   }) : super(HistoryLoadingState()) {
//     on<LoadHistoryEvent>(_loadHistory);
//     on<DeleteScanEvent>(_deleteScan);
//     on<LoadDetailScanEvent>(_loadDetail);
//   }

//   Future<void> _loadHistory(
//     LoadHistoryEvent event,
//     Emitter<HistoryState> emit,
//   ) async {
//     emit(HistoryLoadingState());
//     final scans = await getAllScansUseCase.execute();
//     emit(HistoryLoadedState(scans));
//   }

//   Future<void> _deleteScan(
//     DeleteScanEvent event,
//     Emitter<HistoryState> emit,
//   ) async {
//     await deleteScanUseCase.call(event.id);
//     emit(HistoryDeletedState());

//     final updated = await getAllScansUseCase.execute();
//     emit(HistoryLoadedState(updated));
//   }

//   Future<void> _loadDetail(
//     LoadDetailScanEvent event,
//     Emitter<HistoryState> emit,
//   ) async {
//     emit(HistoryLoadingState());

//     final detail = await getScanDetailUseCase.call(event.id);

//     if (detail == null) {
//       emit(HistoryErrorState("Detail tidak ditemukan"));
//     } else {
//       emit(HistoryDetailLoaded(detail));
//     }
//   }
// }


import 'package:curesee/users/features/history/domain/entities/history_scan.dart';
import 'package:curesee/users/features/history/domain/use_case/get_all_scans_usecase.dart';
import 'package:curesee/users/features/history/domain/use_case/save_scan_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HistoryEvent {}

class SaveScanEvent extends HistoryEvent {
  final HistoryScan scan;
  SaveScanEvent(this.scan);
}

class LoadHistoryEvent extends HistoryEvent {}

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}
class HistoryLoading extends HistoryState {}
class HistoryLoaded extends HistoryState {
  final List<HistoryScan> scans;
  HistoryLoaded(this.scans);
}
class HistorySaving extends HistoryState {}
class HistorySaved extends HistoryState {}
class HistoryError extends HistoryState {
  final String message;
  HistoryError(this.message);
}

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final SaveScanUseCase saveScan;
  final GetAllScansUseCase getAllScans;

  HistoryBloc(this.saveScan, this.getAllScans) : super(HistoryInitial()) {
    on<SaveScanEvent>((event, emit) async {
      await saveScan.execute(event.scan);
      add(LoadHistoryEvent());
    });

    on<LoadHistoryEvent>((event, emit) async {
      emit(HistoryLoading());
      try {
        final data = await getAllScans.execute();
        emit(HistoryLoaded(data));
      } catch (e) {
        emit(HistoryError(e.toString()));
      }
    });
  }
}

