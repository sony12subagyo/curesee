import 'package:curesee/users/features/profile/domain/entities/profil.dart';
import 'package:flutter/material.dart';

class ProfileCardUpdate extends StatelessWidget {
  final Profile profile;
  const ProfileCardUpdate({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: const Color.fromARGB(255, 52, 111, 199),
          ),
          const SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // <-- ikut ukuran isi
            children: [
              Text(
                profile.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(profile.gender, style: const TextStyle(fontSize: 16)),
              Text(
                profile.age.toString(),
                style: const TextStyle(fontSize: 16),
              ),
              Text(profile.email, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
