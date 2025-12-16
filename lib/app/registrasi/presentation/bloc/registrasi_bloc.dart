import 'package:curesee/app/registrasi/domain/use_case/registrasi_use_case.dart';
import 'package:curesee/app/registrasi/presentation/bloc/regisrasi_event.dart';
import 'package:curesee/app/registrasi/presentation/bloc/registrasi_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrasiBloc extends Bloc<RegistrasiEvent, RegistrasiState> {
  final RegistrasiUseCase useCase;

  RegistrasiBloc(this.useCase) : super(RegistrasiInitial()) {
    on<RegistrasiSubmitted>((event, emit) async {
      emit(RegistrasiLoading());
      try {
        await useCase.execute(
          name: event.name,
          email: event.email,
          gender: event.gender,
          age: event.age,
          password: event.password,
        );
        emit(RegistrasiSuccess());
      } catch (e) {
        emit(RegistrasiFailure(e.toString()));
      }
    });
  }
}
