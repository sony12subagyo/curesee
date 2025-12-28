import 'package:curesee/users/features/skin_scane/domain/entities/skin_detection_entity.dart';

abstract class SkinDetectionState {}

class SkinDetectionInitial extends SkinDetectionState {}

class SkinDetectionLoading extends SkinDetectionState {}

class SkinDetectionLoaded extends SkinDetectionState {
  final SkinDetectionEntity result;
  SkinDetectionLoaded(this.result);
}

class SkinDetectionError extends SkinDetectionState {
  final String message;

  SkinDetectionError(this.message);
}
