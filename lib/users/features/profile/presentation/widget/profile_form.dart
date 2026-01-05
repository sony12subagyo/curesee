import 'package:curesee/users/features/profile/domain/entities/profil.dart';
import 'package:curesee/users/features/profile/presentation/pages/about_us_page.dart';
import 'package:curesee/users/features/profile/presentation/pages/profile_update_page.dart';
import 'package:flutter/material.dart';

class ProfileForm extends StatelessWidget {
  final Profile profile;
  const ProfileForm({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Person",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),
          // PERSON CARD
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const SizedBox(width: 4),
                const Icon(Icons.person, color: Colors.black, size: 18),
                const SizedBox(width: 8),

                const Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ), // 🔹 CHANGED
                ),

                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.black, size: 18),
                  padding: EdgeInsets.zero, // 🔹 CHANGED
                  constraints: const BoxConstraints(), // 🔹 CHANGED
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfileUpdatePage(profile: profile),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 6), // 🔹 CHANGED

          const Text(
            "About us",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),
          // ABOUT US CARD
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.info_rounded,
                    color: Colors.black,
                    size: 18,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutUsPage()),
                    );
                  },
                ),
                const SizedBox(width: 6),
                const Text(
                  "About Us",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          SizedBox(
            height: 42,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                print("Logout ditekan");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // 🔹 CHANGED
                ),
                padding: const EdgeInsets.symmetric(vertical: 8), // 🔹 CHANGED
              ),
              child: const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
