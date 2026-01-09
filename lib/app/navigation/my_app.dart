import 'package:curesee/app/login/data/data_source/login_remote_datasource.dart';
import 'package:curesee/app/navigation/auth_gate.dart';
import 'package:curesee/users/features/history/data/data_source/history_local_db.dart';
import 'package:curesee/users/features/history/data/repositories/history_repository_impl.dart';
import 'package:curesee/users/features/history/domain/use_case/get_all_scans_usecase.dart';
import 'package:curesee/users/features/history/domain/use_case/save_scan_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../users/features/history/presentation/bloc/history_bloc.dart';
import '../login/presentation/bloc/login_bloc.dart';
import '../login/domain/use_case/admin_login_usecase.dart';
import '../login/domain/use_case/user_login_usecase.dart';
import '../login/data/repositories/admin_login_repository_impl.dart';
import '../login/data/repositories/user_login_repository_impl.dart';
import '../login/presentation/pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// ===== USER LOGIN =====
    final loginRemote = LoginRemoteDataSource(
      baseUrl: 'https://47ee97b1e5be.ngrok-free.app/api',
    );

    final userRepo = UserLoginRepositoryImpl(loginRemote);
    final userLoginUsecase = UserLoginUsecase(userRepo);

    /// ===== ADMIN LOGIN =====
    final adminRepository = AdminLoginRepositoryImpl(
      client: http.Client(),

      baseUrl: 'https://47ee97b1e5be.ngrok-free.app/api',
    );
    final adminLoginUsecase = AdminLoginUsecase(adminRepository);

    // return BlocProvider(
    //   create: (_) => LoginBloc(
    //     userLoginUsecase: userLoginUsecase,
    //     adminLoginUsecase: adminLoginUsecase,
    //   ),
    //   child: const MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: AuthGate(),

    //   ),
    // );

    

    return MultiBlocProvider(
      providers: [
        // ================= LOGIN =================
        BlocProvider(
          create: (_) => LoginBloc(
            userLoginUsecase: userLoginUsecase,
            adminLoginUsecase: adminLoginUsecase,
          ),
        ),

        // ================= HISTORY =================
        // BlocProvider(
        //   create: (_) {
        //     final repo = HistoryRepositoryImpl(HistoryLocalDb());
        //     return HistoryBloc(SaveScanUseCase(repo), GetAllScansUseCase(repo))
        //       ..add(LoadHistoryEvent());
        //   },
        // ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthGate(),
      ),
    );
  }
}
