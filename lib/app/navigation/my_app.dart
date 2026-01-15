import 'package:curesee/app/login/data/data_source/login_remote_datasource.dart';
import 'package:curesee/users/features/history/data/data_source/history_local_db.dart';
import 'package:curesee/users/features/history/data/repositories/history_repository_impl.dart';
import 'package:curesee/users/features/history/domain/use_case/get_all_scans_usecase.dart';
import 'package:curesee/users/features/history/presentation/bloc/history_bloc.dart';
import 'package:curesee/users/features/history/presentation/bloc/history_event.dart';
import 'package:curesee/app/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../login/presentation/bloc/login_bloc.dart';
import '../login/domain/use_case/admin_login_usecase.dart';
import '../login/domain/use_case/user_login_usecase.dart';
import '../login/data/repositories/admin_login_repository_impl.dart';
import '../login/data/repositories/user_login_repository_impl.dart';
import 'package:curesee/users/features/history/data/data_source/history_remote_api.dart';
import 'package:curesee/users/features/history/domain/use_case/get_scan_usecase.dart';
import 'package:curesee/users/features/history/domain/use_case/delete_scan_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:curesee/app/config/app_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //login untuk pengguna
    final loginRemote = LoginRemoteDataSource(baseUrl: AppConfig.baseUrl);

    final userRepo = UserLoginRepositoryImpl(loginRemote);
    final userLoginUsecase = UserLoginUsecase(userRepo);

    //login untuk admin
    final adminRepository = AdminLoginRepositoryImpl(
      client: http.Client(),
      baseUrl: AppConfig.baseUrl,
    );
    final adminLoginUsecase = AdminLoginUsecase(adminRepository);

    return MultiProvider(
      providers: [
        Provider<HistoryRemoteApi>(
          create: (_) => HistoryRemoteApi(
            getToken: () async {
              final user = FirebaseAuth.instance.currentUser;
              if (user == null) throw Exception("Not logged in");

              final token = await user.getIdToken();
              return token!; // 🔥 paksa non-null karena Firebase pasti kasih
            },
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => LoginBloc(
              userLoginUsecase: userLoginUsecase,
              adminLoginUsecase: adminLoginUsecase,
            ),
          ),

          BlocProvider(
            create: (context) {
              final localDb = HistoryLocalDb();
              final remoteApi = context.read<HistoryRemoteApi>();
              final repo = HistoryRepositoryImpl(localDb, remoteApi);

              return HistoryBloc(
                getAllScans: GetAllScansUseCase(repo),
                getScan: GetScanUseCase(repo),
                deleteScan: DeleteScanUseCase(repo),
              )..add(LoadHistoryEvent());
            },
          ),
        ],

        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
