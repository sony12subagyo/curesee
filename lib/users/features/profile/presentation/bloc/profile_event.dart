import 'dart:io';
import 'package:curesee/users/features/profile/domain/entities/profile.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final Profile profile;
  UpdateProfileEvent(this.profile);
}

class UploadAvatarEvent extends ProfileEvent {
  final File file;
  UploadAvatarEvent(this.file);
}

class LogoutEvent extends ProfileEvent {}
