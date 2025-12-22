import 'package:curesee/users/features/profile/presentation/widget/profile_card_update.dart';
import 'package:flutter/material.dart';

class ProfileUpdatePage extends StatelessWidget {
  final profile;
  const ProfileUpdatePage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(children: [ProfileCardUpdate(profile: profile)]);
  }
}
