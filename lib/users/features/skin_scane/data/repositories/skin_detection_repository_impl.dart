import 'dart:io';

import 'package:curesee/users/features/skin_scane/data/data_source/acne_subtype_tflite_datasource.dart';
import 'package:curesee/users/features/skin_scane/data/data_source/main_disease_tflite_datasource.dart';
import 'package:curesee/users/features/skin_scane/domain/repositories/skin_detection_repository.dart';
import '../../domain/entities/skin_detection_entity.dart';

class SkinDetectionRepositoryImpl implements SkinDetectionRepository {
  final _mainModel = MainDiseaseTFLiteDatasource();
  final _acneModel = AcneSubtypeTFLiteDatasource();

  bool _isLoaded = false;

  Future<void> _loadModels() async {
    if (!_isLoaded) {
      await _mainModel.load();
      await _acneModel.load();
      _isLoaded = true;
    }
  }

  @override
  Future<SkinDetectionEntity> detectSkinDisease(File image) async {
    await _loadModels();

    final mainResult = await _mainModel.predict(image);

    String? subtype;
    double? subtypeConfidence;

    if (mainResult['label'] == "acne") {
      final sub = await _acneModel.predict(image);
      subtype = sub['label'];
      subtypeConfidence = sub['confidence'];
    }

    return SkinDetectionEntity(
      mainDisease: mainResult['label'],
      mainConfidence: mainResult['confidence'],
      acneSubtype: subtype,
      acneConfidence: subtypeConfidence,
    );
  }
}
