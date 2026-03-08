import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_bloc_event.dart';
import 'add_image_state.dart';
import 'add_image_usecase.dart';

class AddImageBloc extends Bloc<AddImageEvent, AddImageState> {
  final AddImageUsecase pickImageUseCase;

  AddImageBloc(this.pickImageUseCase) : super(const AddImageState()) {
    on<PickImageRequested>(_onPickImage);
    on<ClearImageRequested>(_onClearImage);
  }

  Future<void> _onPickImage(
    PickImageRequested event,
    Emitter<AddImageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final File? image = await pickImageUseCase();

      emit(
        state.copyWith(
          image: image,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Gagal mengambil gambar',
        ),
      );
    }
  }

  void _onClearImage(
    ClearImageRequested event,
    Emitter<AddImageState> emit,
  ) {
    emit(const AddImageState());
  }
}
