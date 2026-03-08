import 'package:curesee/app/login/data/data_source/auth_firebase_service.dart';
import 'package:curesee/users/features/profile/data/data_souce/profile_remote_data_source.dart';
import 'package:curesee/users/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:curesee/users/features/profile/domain/use_case/get_profile.dart';
import 'package:curesee/users/features/profile/domain/use_case/update_profile.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:curesee/users/features/beranda/presentation/pages/beranda_page.dart';
import 'package:curesee/users/features/profile/presentation/pages/profil_page.dart';
import 'package:curesee/users/features/history/presentation/pages/history_page.dart';
import 'package:curesee/users/features/more/presentation/pages/more_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPages {
  static final pages = <Widget>[
    const BerandaPage(),
    const HistoryPage(),
    const MorePage(),

    BlocProvider(
      create: (_) {
        final repository = ProfileRepositoryImpl(ProfileRemoteDataSource());

        return ProfileBloc(
          getProfile: GetProfile(repository),
          updateProfile: UpdateProfile(repository),
          authService: AuthFirebaseService(),
        );
      },
      child: const ProfilePage(),
    ),
  ];
}
