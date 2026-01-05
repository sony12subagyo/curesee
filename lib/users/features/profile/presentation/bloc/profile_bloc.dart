import 'package:curesee/users/features/profile/domain/use_case/get_profile.dart';
import 'package:curesee/users/features/profile/domain/use_case/update_profile.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_event.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;
  final UpdateProfile updateProfile;

  ProfileBloc({required this.getProfile, required this.updateProfile})
    : super(ProfileInitial()) {
    // 🔹 Load profile (GET dari Laravel)
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final data = await getProfile.execute();
        emit(ProfileLoaded(data));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    // 🔹 Update profile (PUT ke Laravel)
    on<UpdateProfileEvent>((event, emit) async {
      try {
        await updateProfile(event.profile); // kirim ke Laravel
        final updated = await getProfile.execute(); // ambil ulang
        emit(ProfileLoaded(updated));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
