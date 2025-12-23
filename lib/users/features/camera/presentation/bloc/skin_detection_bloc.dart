import 'package:curesee/users/features/camera/domain/mappers/skin_disease_mapper.dart';
import 'package:curesee/users/features/camera/domain/usecase/detect_skin_disease.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'skin_detection_event.dart';
import 'skin_detection_state.dart';

class SkinDetectionBloc
    extends Bloc<SkinDetectionEvent, SkinDetectionState> {
  final DetectSkinDisease detectSkinDisease;

  SkinDetectionBloc(this.detectSkinDisease)
      : super(SkinDetectionInitial()) {
    on<DetectSkinFromImage>(_onDetectSkin);
  }

  Future<void> _onDetectSkin(
    DetectSkinFromImage event,
    Emitter<SkinDetectionState> emit,
  ) async {
    emit(SkinDetectionLoading());

    try {
      final detectionEntity =
          await detectSkinDisease.execute(event.image);

      final mappedDisease =
          SkinDiseaseMapper.map(detectionEntity);

      emit(SkinDetectionSuccess(mappedDisease));
    } catch (e) {
      emit(SkinDetectionError('Gagal mendeteksi penyakit kulit'));
    }
  }
}
