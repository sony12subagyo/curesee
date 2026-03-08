import 'package:curesee/app/login/presentation/pages/login_page.dart';
import 'package:curesee/users/features/profile/domain/entities/profile.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_event.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_state.dart';
import 'package:curesee/users/features/profile/presentation/widget/widget_profile_page/profile_form/profile_form.dart';
import 'package:curesee/users/features/profile/presentation/widget/widget_profile_page/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(LoadProfileEvent());
    });
  }

  Future<void> _onRefresh() async {
    context.read<ProfileBloc>().add(LoadProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoggedOut) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
          );
        }

        if (state is ProfileError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            final Profile user = state.profile;

            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    children: [
                      ProfileCard(profile: user),
                      const SizedBox(height: 16),
                      ProfileForm(profile: user),
                    ],
                  ),
                ),
              ),
            );
          }

          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
