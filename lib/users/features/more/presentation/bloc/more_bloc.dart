import 'package:curesee/users/features/more/presentation/bloc/more_event.dart';
import 'package:curesee/users/features/more/presentation/bloc/more_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {
  MoreBloc()
    : super(MoreState(selectedPusatBantuan: MorePusatBantuan.informasiumum)) {
    on<PilihanPusatBantuan>((event, emit) {
      emit(state.copyWith(selectedPusatBantuan: event.pusatBantuan));
    });
  }
}
