import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curesee/admin/features/blog/domain/usecase/add_image_usecase.dart';
import 'add_bloc_event.dart';
import 'add_image_state.dart';

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
    // ⏳ loading
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final File? image = await pickImageUseCase();

      if (image == null) {
        emit(state.copyWith(isLoading: false));
        return;
      }

      // ✅ success
      emit(state.copyWith(image: image, isLoading: false, errorMessage: null));
    } catch (e) {
      // ❌ error
      emit(
        state.copyWith(isLoading: false, errorMessage: 'Failed to pick image'),
      );
    }
  }

  void _onClearImage(ClearImageRequested event, Emitter<AddImageState> emit) {
    emit(const AddImageState());
  }
}
