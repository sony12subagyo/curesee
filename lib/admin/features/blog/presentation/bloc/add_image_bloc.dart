import 'dart:io';
import 'package:curesee/admin/features/blog/domain/usecase/add_image_usecase.dart';
import 'package:curesee/admin/features/blog/presentation/bloc/add_bloc_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_image_state.dart';

class AddImageBloc extends Bloc<AddImageEvent, AddImageState> {
  final AddImageUsecase pickImageUseCase;

  AddImageBloc(this.pickImageUseCase) : super(AddImageInitial()) {
    on<PickImageRequested>(_onPickImage);
    on<ClearImageRequested>((event, emit) {
      emit(AddImageInitial());
    });
  }

  Future<void> _onPickImage(
    PickImageRequested event,
    Emitter<AddImageState> emit,
  ) async {
    emit(AddImageLoading());

    try {
      final File? image = await pickImageUseCase();

      if (image == null) {
        emit(AddImageInitial());
        return;
      }

      emit(AddImageSuccess(image));
    } catch (e) {
      emit(AddImageFailure('Failed to pick image'));
    }
  }
}
