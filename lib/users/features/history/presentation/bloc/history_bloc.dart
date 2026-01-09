import 'package:curesee/users/features/history/domain/use_case/delete_scan_usecase.dart';
import 'package:curesee/users/features/history/domain/use_case/get_all_scans_usecase.dart';
import 'package:curesee/users/features/history/domain/use_case/get_scan_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/history_scan.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetAllScansUseCase getAllScansUseCase;
  final GetScanDetailUseCase getScanDetailUseCase;
  final DeleteScanUseCase deleteScanUseCase;

  HistoryBloc({
    required this.getAllScansUseCase,
    required this.getScanDetailUseCase,
    required this.deleteScanUseCase,
  }) : super(HistoryLoadingState()) {
    on<LoadHistoryEvent>(_loadHistory);
    on<DeleteScanEvent>(_deleteScan);
    on<LoadDetailScanEvent>(_loadDetail);
  }

  Future<void> _loadHistory(
      LoadHistoryEvent event, Emitter<HistoryState> emit) async {
    emit(HistoryLoadingState());
    final scans = await getAllScansUseCase.execute();
    emit(HistoryLoadedState(scans));
  }

  Future<void> _deleteScan(
      DeleteScanEvent event, Emitter<HistoryState> emit) async {
    await deleteScanUseCase.call(event.id);
    emit(HistoryDeletedState());

    final updated = await getAllScansUseCase.execute();
    emit(HistoryLoadedState(updated));
  }

  Future<void> _loadDetail(
      LoadDetailScanEvent event, Emitter<HistoryState> emit) async {
    emit(HistoryLoadingState());

    final detail = await getScanDetailUseCase.call(event.id);

    if (detail == null) {
      emit(HistoryErrorState("Detail tidak ditemukan"));
    } else {
      emit(HistoryDetailLoaded(detail));
    }
  }
}