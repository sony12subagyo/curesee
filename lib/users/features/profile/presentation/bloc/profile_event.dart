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

class LogoutEvent extends ProfileEvent {}
