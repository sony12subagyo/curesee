import 'package:curesee/admin/app/responsive_layout.dart';
import 'package:curesee/admin/features/users/presentation/pages/admin_layout.dart';
import 'package:curesee/admin/features/users/presentation/widgets/user_list_dekstop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:curesee/app/navigation/background_wrapper.dart';
import 'package:curesee/admin/features/users/presentation/bloc/user_bloc.dart';
import 'package:curesee/admin/features/users/presentation/bloc/user_state.dart';

import '../widgets/user_list_mobile.dart';
import '../widgets/user_list_tablet.dart';

class AdminUserView extends StatelessWidget {
  const AdminUserView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return AdminLayout(
      currentIndex: 1,
      child: BackgroundWrapper(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is UserFailure) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state is UserLoaded) {
              return ResponsiveLayout(
                mobile: UserListMobile(users: state.users),
                tablet: UserListTablet(users: state.users),
                desktop: UserListDesktop(users: state.users),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
