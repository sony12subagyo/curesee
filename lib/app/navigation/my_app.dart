import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../login/presentation/bloc/login_bloc.dart';
import '../login/domain/use_case/login_usecase.dart';
import '../login/data/data_source/login_remote_datasource.dart';
import '../login/data/repositories/login_repository_impl.dart';
import '../login/presentation/pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final remoteDataSource = LoginRemoteDataSource();
    final repository = LoginRepositoryImpl(remoteDataSource);
    final loginUsecase = LoginUsecase(repository);

    return BlocProvider(
      create: (_) => LoginBloc(loginUsecase),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
