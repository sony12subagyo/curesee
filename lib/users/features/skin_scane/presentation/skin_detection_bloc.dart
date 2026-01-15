import 'dart:developer';
import 'package:curesee/users/features/skin_scane/domain/use_case/detect_skin_disease.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'skin_detection_event.dart';
import 'skin_detection_state.dart';

class SkinDetectionBloc extends Bloc<SkinDetectionEvent, SkinDetectionState> {
  final DetectSkinDisease detectSkinDisease;

  SkinDetectionBloc(this.detectSkinDisease) : super(SkinDetectionInitial()) {
    on<DetectSkinFromImage>(_onDetectSkin);
  }

  Future<void> _onDetectSkin(
    DetectSkinFromImage event,
    Emitter<SkinDetectionState> emit,
  ) async {
    emit(SkinDetectionLoading());

    try {
      final result = await detectSkinDisease.execute(event.image);
      emit(SkinDetectionLoaded(result));
    } catch (e, stack) {
      log("SKIN DETECTION ERROR: $e", stackTrace: stack);
      emit(SkinDetectionError(e.toString()));
    }
  }
}

//mengatur alur proses scan kulit dari foto sampai hasil AI muncul di layar.