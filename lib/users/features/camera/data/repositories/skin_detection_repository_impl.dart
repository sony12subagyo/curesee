import 'dart:io';

import 'package:curesee/users/features/camera/data/data_source/mlkit_custom_model_datasource.dart';
import 'package:curesee/users/features/camera/domain/reporitories/skin_detection_repository.dart';

import '../../domain/entities/skin_detection_entity.dart';
import '../models/skin_detection_model.dart';

class SkinDetectionRepositoryImpl implements SkinDetectionRepository {
  final MlKitCustomModelDatasource datasource;

  SkinDetectionRepositoryImpl(this.datasource);

  @override
  Future<SkinDetectionEntity> detectSkinDisease(File image) async {
    final List<SkinDetectionModel> results =
        await datasource.detectSkin(image);

    if (results.isEmpty) {
      return const SkinDetectionEntity(
        rawLabel: 'unknown',
        confidence: 0.0,
      );
    }

    // ambil confidence tertinggi
    results.sort((a, b) => b.confidence.compareTo(a.confidence));
    final top = results.first;

    return SkinDetectionEntity(
      rawLabel: top.label,
      confidence: top.confidence,
    );
  }
}
