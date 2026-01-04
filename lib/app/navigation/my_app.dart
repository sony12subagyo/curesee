import 'package:curesee/app/navigation/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

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
    final userRepository = UserLoginRepositoryImpl();
    final userLoginUsecase = UserLoginUsecase(userRepository);

    /// ===== ADMIN LOGIN =====
    final adminRepository = AdminLoginRepositoryImpl(
      client: http.Client(),
      baseUrl: 'https://a6be1cef336e.ngrok-free.app/api',
    );
    final adminLoginUsecase = AdminLoginUsecase(adminRepository);

    return BlocProvider(
      create: (_) => LoginBloc(
        userLoginUsecase: userLoginUsecase,
        adminLoginUsecase: adminLoginUsecase,
      ),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeLayout(),
      ),
    ); 
  }
}
