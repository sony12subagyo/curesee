import 'package:curesee/features/profile/domain/entities/profil.dart';
import 'package:curesee/features/profile/domain/use_case/get_all_profile.dart';
import 'package:curesee/features/profile/domain/use_case/update_profile.dart';
import 'package:curesee/features/profile/presentation/bloc/profile_event.dart';
import 'package:curesee/features/profile/presentation/bloc/profile_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetAllProfile getAllProfile;
  final UpdateProfile updateProfile;

  ProfileBloc({required this.getAllProfile, required this.updateProfile})
    : super(ProfileInitial()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final data = await getAllProfile();
        emit(ProfileLoaded(data));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
