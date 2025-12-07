import 'package:curesee/features/profile/domain/entities/profil.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final int userid;
  final Profile profile;
  UpdateProfileEvent(this.userid, this.profile);
}
