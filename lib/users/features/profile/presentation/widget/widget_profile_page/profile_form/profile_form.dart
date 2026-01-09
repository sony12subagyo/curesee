import 'package:curesee/users/features/profile/domain/entities/profile.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:curesee/users/features/profile/presentation/pages/about_us_page.dart';
import 'package:curesee/users/features/profile/presentation/pages/profile_update_page.dart';
import 'package:curesee/users/features/profile/presentation/widget/widget_profile_page/profile_form/profile_item.dart';
import 'package:curesee/users/features/profile/presentation/widget/widget_profile_page/profile_form/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileForm extends StatelessWidget {
  final Profile profile;
  const ProfileForm({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();

    return Material(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 128, 255),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Edit Profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            ProfileMenuItem(
              icon: Icons.person,
              title: "Edit Profile",
              trailing: const Icon(Icons.edit, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: profileBloc,
                      child: ProfileUpdatePage(profile: profile),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),
            const Text(
              "About Us",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            ProfileMenuItem(
              icon: Icons.info_rounded,
              title: "About Us",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: profileBloc,
                      child: const AboutUsPage(),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 32),

            LogoutButton(
              onPressed: () {
                // context.read<ProfileBloc>().add(LogoutEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
