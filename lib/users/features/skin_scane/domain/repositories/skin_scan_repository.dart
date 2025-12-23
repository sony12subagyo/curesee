import 'dart:io';
import 'package:curesee/users/features/skin_scane/domain/entities/entity_scan_ml.dart';

abstract class SkinScanRepository {
  Future<EntityScanMl> scanSkin(File image);
}
