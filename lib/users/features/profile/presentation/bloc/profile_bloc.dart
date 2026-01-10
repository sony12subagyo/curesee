import 'package:curesee/app/login/data/data_source/auth_firebase_service.dart';
import 'package:curesee/users/features/profile/domain/use_case/get_profile.dart';
import 'package:curesee/users/features/profile/domain/use_case/update_profile.dart';
import 'package:curesee/users/features/profile/domain/use_case/upload_avatar.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_event.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;
  final UpdateProfile updateProfile;
  final UploadAvatar uploadAvatar;
  final AuthFirebaseService authService;

  ProfileBloc({
    required this.getProfile,
    required this.updateProfile,
    required this.uploadAvatar,
    required this.authService,
  }) : super(ProfileInitial()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final data = await getProfile.execute();
        emit(ProfileLoaded(data));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<UpdateProfileEvent>((event, emit) async {
      try {
        await updateProfile(event.profile);
        final updated = await getProfile.execute();
        emit(ProfileLoaded(updated));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<UploadAvatarEvent>((event, emit) async {
      try {
        await uploadAvatar.execute(event.file);
        final updated = await getProfile.execute();
        emit(ProfileLoaded(updated));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
    on<LogoutEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        await authService.logout();
        emit(ProfileLoggedOut());
      } catch (e) {
        emit(ProfileError("Gagal Logout"));
      }
    });
  }
}
