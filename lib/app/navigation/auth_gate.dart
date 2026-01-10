// import 'package:curesee/users/features/beranda/presentation/pages/beranda_page.dart';
import 'package:curesee/app/login/data/data_source/auth_firebase_service.dart';
import 'package:curesee/app/navigation/home_layout.dart';
import 'package:curesee/users/features/profile/data/data_souce/profile_remote_data_source.dart';
import 'package:curesee/users/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:curesee/users/features/profile/domain/use_case/get_profile.dart';
import 'package:curesee/users/features/profile/domain/use_case/update_profile.dart';
import 'package:curesee/users/features/profile/domain/use_case/upload_avatar.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_bloc.dart';

import 'package:curesee/users/features/profile/presentation/bloc/profile_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login/presentation/pages/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> _canEnter() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user == null) return false;

    await user.reload();
    final freshUser = auth.currentUser;

    if (freshUser == null) return false;

    if (!freshUser.emailVerified) {
      await auth.signOut();
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _canEnter(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) {
                  final remote = ProfileRemoteDataSource();
                  final repo = ProfileRepositoryImpl(remote);

                  return ProfileBloc(
                    getProfile: GetProfile(repo),
                    updateProfile: UpdateProfile(repo),
                    uploadAvatar: UploadAvatar(repo),
                    authService: AuthFirebaseService(),
                  )..add(LoadProfileEvent());
                },
              ),
            ],
            child: const HomeLayout(),
          );
        }

        return const LoginPage();
      },
    );
  }
}
