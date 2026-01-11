import 'package:curesee/users/features/profile/domain/entities/profile.dart';
import 'package:curesee/users/features/profile/presentation/widget/gender_label.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final Profile profile;
  const ProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor:
                  Colors.blue.shade100, // sesuaikan dengan theme CureSee
              child: const Icon(Icons.person, size: 40, color: Colors.blue),
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    profile.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),
                  Text(
                    profile.email,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    genderLabel(profile.gender),
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    profile.age.toString() + " tahun",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
