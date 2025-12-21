import 'dart:io';
import 'package:curesee/users/features/skin_scane/domain/entities/entity_scan_ml.dart';
import 'package:curesee/users/features/skin_scane/domain/repositories/skin_scan_repository.dart';

class SkinScanUsecase {
  final SkinScanRepository repository;
  SkinScanUsecase(this.repository);

  Future<EntityScanMl> execute(File image) async {
    return await repository.scanSkin(image);
  }
}
