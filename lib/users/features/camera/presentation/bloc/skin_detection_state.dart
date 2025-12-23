import 'package:curesee/users/features/camera/domain/entities/skin_disease_entity.dart';

abstract class SkinDetectionState {}

class SkinDetectionInitial extends SkinDetectionState {}

class SkinDetectionLoading extends SkinDetectionState {}

class SkinDetectionSuccess extends SkinDetectionState {
  final SkinDiseaseEntity result;

  SkinDetectionSuccess(this.result);
}

class SkinDetectionError extends SkinDetectionState {
  final String message;

  SkinDetectionError(this.message);
}
