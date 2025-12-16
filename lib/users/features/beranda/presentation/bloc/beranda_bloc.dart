import 'package:curesee/users/features/beranda/domain/usecase/get_beranda_list.dart';
import 'package:curesee/users/features/beranda/presentation/bloc/beranda_event.dart';
import 'package:curesee/users/features/beranda/presentation/bloc/beranda_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BerandaBloc extends Bloc<BerandaEvent, BerandaState> {
  final GetBerandaList getBerandaList;

  BerandaBloc(this.getBerandaList) : super(BerandaInitial()) {
    on<GetBerandaListEvent>((event, emit) async {
      emit(BerandaLoading());
      final result = await getBerandaList();
      emit(BerandaLoaded(result));
    });
  }
}
