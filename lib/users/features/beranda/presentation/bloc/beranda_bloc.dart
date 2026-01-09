import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repository/beranda_repository.dart';
import 'beranda_event.dart';
import 'beranda_state.dart';

class BerandaBloc extends Bloc<BerandaEvent, BerandaState> {
  final BerandaRepository repository;

  BerandaBloc(this.repository) : super(BerandaInitial()) {
    on<GetBerandaRequested>(_onGet);
  }

  Future<void> _onGet(
    GetBerandaRequested event,
    Emitter<BerandaState> emit,
  ) async {
    emit(BerandaLoading());
    try {
      final data = await repository.getBeranda();
      emit(BerandaLoaded(data));
    } catch (_) {
      emit(BerandaFailure('Gagal mengambil blog'));
    }
  }
}
