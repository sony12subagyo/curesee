import 'dart:io';

import 'package:curesee/users/features/skin_scane/data/data_source/main_disease_tflite_datasource.dart';
import 'package:curesee/users/features/skin_scane/domain/entities/skin_detection_entity.dart';
import 'package:curesee/users/features/skin_scane/domain/repositories/skin_detection_repository.dart';

class SkinDetectionRepositoryImpl implements SkinDetectionRepository {
  final MainDiseaseTFLiteDatasource datasource = MainDiseaseTFLiteDatasource();
  @override
  Future<SkinDetectionEntity> detectSkinDisease(File image) async {
    final predictions = (await datasource.predictTop3(image))
        .map(
          (e) => DiseasePrediction(
            e["label"] as String,
            e["confidence"] as double,
          ),
        )
        .toList();

    return SkinDetectionEntity(predictions);
  }
}
