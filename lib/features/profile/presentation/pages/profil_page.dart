import 'package:curesee/features/profile/domain/entities/profil.dart';
import 'package:curesee/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:curesee/features/profile/presentation/bloc/profile_event.dart';
import 'package:curesee/features/profile/presentation/bloc/profile_state.dart';
import 'package:curesee/features/profile/presentation/widget/jumlah_analisis_card.dart';
import 'package:curesee/features/profile/presentation/widget/profile_card.dart';

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
    context.read<ProfileBloc>().add(LoadProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProfileError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is ProfileLoaded) {
          final Profile user = state.profileList.first;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: ProfileCard(profile: user),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [JumlahAnalisis()],
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
