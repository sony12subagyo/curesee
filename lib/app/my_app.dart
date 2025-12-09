import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/login/presentation/bloc/login_bloc.dart';
import '../features/login/domain/use_case/login_usecase.dart';
import '../features/login/data/data_source/login_remote_datasource.dart';
import '../features/login/data/repositories/login_repository_impl.dart';
import '../features/login/presentation/pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSource = DummyLoginDataSource();
    final repo = LoginRepositoryImpl(dataSource);
    final usecase = LoginUsecase(repo);

    return BlocProvider(
      create: (_) => LoginBloc(usecase),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'home_layout.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const HomeLayout(),
//     );
//   }
// }