import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/get_all_scans_usecase.dart';
import '../../domain/use_case/get_scan_usecase.dart';
import '../../domain/use_case/delete_scan_usecase.dart';

import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetAllScansUseCase getAllScans;
  final GetScanUseCase getScan;
  final DeleteScanUseCase deleteScan;

  HistoryBloc({
    required this.getAllScans,
    required this.getScan,
    required this.deleteScan,
  }) : super(HistoryInitial()) {
    on<LoadHistoryEvent>(_onLoadHistory);
    on<LoadDetailScanEvent>(_onLoadDetail);
    on<DeleteScanEvent>(_onDelete);
  }

  Future<void> _onLoadHistory(
    LoadHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryLoading());
    try {
      final scans = await getAllScans();
      emit(HistoryLoaded(scans));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> _onLoadDetail(
    LoadDetailScanEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryLoading());
    try {
      final scan = await getScan(event.id);
      if (scan == null) throw Exception("Data tidak ditemukan");
      emit(HistoryDetailLoaded(scan));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> _onDelete(
    DeleteScanEvent event,
    Emitter<HistoryState> emit,
  ) async {
    try {
      await deleteScan(event.id);
      final scans = await getAllScans();
      emit(HistoryLoaded(scans));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}


// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../domain/use_case/get_all_scans_usecase.dart';
// import '../../domain/use_case/get_scan_usecase.dart';
// import '../../domain/use_case/delete_scan_usecase.dart';
// import '../../domain/use_case/save_scan_usecase.dart';

// import 'history_event.dart';
// import 'history_state.dart';

// class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
//   final GetAllScansUseCase getAllScans;
//   final GetScanUseCase getScan;
//   final DeleteScanUseCase deleteScan;
//   final SaveScanUseCase saveScan;

//   HistoryBloc({
//     required this.getAllScans,
//     required this.getScan,
//     required this.deleteScan,
//     required this.saveScan,
//   }) : super(HistoryInitial()) {
//     on<LoadHistoryEvent>(_onLoadHistory);
//     on<LoadDetailScanEvent>(_onLoadDetail);
//     on<DeleteScanEvent>(_onDelete);
//     on<SaveScanEvent>(_onSaveScan);
//   }

//   // ==========================
//   // LOAD ALL HISTORY
//   // ==========================
//   Future<void> _onLoadHistory(
//     LoadHistoryEvent event,
//     Emitter<HistoryState> emit,
//   ) async {
//     emit(HistoryLoading());
//     try {
//       final scans = await getAllScans();
//       emit(HistoryLoaded(scans));
//     } catch (e) {
//       emit(HistoryError(e.toString()));
//     }
//   }

//   // ==========================
//   // LOAD DETAIL SCAN
//   // ==========================
//   Future<void> _onLoadDetail(
//     LoadDetailScanEvent event,
//     Emitter<HistoryState> emit,
//   ) async {
//     emit(HistoryLoading());
//     try {
//       final scan = await getScan(event.id);
//       if (scan == null) {
//         throw Exception('Data tidak ditemukan');
//       }
//       emit(HistoryDetailLoaded(scan));
//     } catch (e) {
//       emit(HistoryError(e.toString()));
//     }
//   }

//   // ==========================
//   // SAVE SCAN
//   // ==========================
//   Future<void> _onSaveScan(
//     SaveScanEvent event,
//     Emitter<HistoryState> emit,
//   ) async {
//     try {
//       await saveScan(
//         imagePath: event.imagePath,
//         label: event.label,
//         confidence: event.confidence,
//       );

//       // Refresh history setelah simpan
//       final scans = await getAllScans();
//       emit(HistoryLoaded(scans));
//     } catch (e) {
//       emit(HistoryError(e.toString()));
//     }
//   }

//   // ==========================
//   // DELETE SCAN
//   // ==========================
//   Future<void> _onDelete(
//     DeleteScanEvent event,
//     Emitter<HistoryState> emit,
//   ) async {
//     try {
//       await deleteScan(event.id);
//       final scans = await getAllScans();
//       emit(HistoryLoaded(scans));
//     } catch (e) {
//       emit(HistoryError(e.toString()));
//     }
//   }
// }
