import 'package:curesee/admin/features/users/data/data_source/user_remote_data.dart';
import 'package:curesee/admin/features/users/data/repositories/user_repository_impl.dart';
import 'package:curesee/admin/features/users/presentation/bloc/user_bloc.dart';
import 'package:curesee/admin/features/users/presentation/bloc/user_event.dart';
import 'package:curesee/admin/features/users/presentation/pages/admin_user_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          UserBloc(
            UserRepositoryImpl(
              UserRemoteDatasource(),
            ),
          )..add(GetUsersRequested()),
      child: const AdminUserView(),
    );
  }
}