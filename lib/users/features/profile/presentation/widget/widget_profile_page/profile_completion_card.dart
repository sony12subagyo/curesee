import 'package:curesee/users/features/profile/domain/entities/profile.dart';
import 'package:flutter/material.dart';

class ProfileCompletionCard extends StatelessWidget {
  final Profile profile;

  const ProfileCompletionCard({super.key, required this.profile});

  double _calculateCompletion() {
    double score = 0;

    if (profile.name.trim().isNotEmpty) score += 0.25;
    if (profile.email.trim().isNotEmpty) score += 0.25;
    if (profile.gender.trim().isNotEmpty) score += 0.20;
    if (profile.age > 0) score += 0.20;
    if (profile.avatarUrl.trim().isNotEmpty) score += 0.10;

    return score.clamp(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    final completion = _calculateCompletion();
    final percent = (completion * 100).toInt();

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.person_outline, size: 18),
                SizedBox(width: 6),
                Text(
                  "Profile Completion",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              "$percent% Complete",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Text(
              percent == 100
                  ? "Your profile is complete"
                  : "Complete your data for better skin analysis",
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),

            const SizedBox(height: 12),

            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: completion,
                minHeight: 8,
                backgroundColor: Colors.grey.shade200,
                color: const Color.fromARGB(255, 0, 128, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
