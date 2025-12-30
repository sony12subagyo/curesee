import 'package:curesee/app/registrasi/presentation/bloc/regisrasi_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_case/registrasi_use_case.dart';
import 'registrasi_state.dart';

class RegistrasiBloc extends Bloc<RegistrasiEvent, RegistrasiState> {
  final RegistrasiUseCase useCase;

  RegistrasiBloc(this.useCase) : super(RegistrasiInitial()) {
    on<RegistrasiSubmitted>((event, emit) async {
      emit(RegistrasiLoading());
      try {
        await useCase.execute(event.entity);
        emit(RegistrasiSuccess());
      } catch (e) {
        emit(RegistrasiFailure(e.toString()));
      }
    });
  }
}
