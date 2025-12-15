import 'package:flutter/material.dart';

class UpdateProfileCard extends StatelessWidget {
  const UpdateProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul
            const Text(
              "Person",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.edit),
                  SizedBox(width: 10),
                  Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            const Text(
              "Person",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.info_rounded),
                  SizedBox(width: 10),
                  Text(
                    "About Us",
                    style: TextStyle(fontSize: 16, color: Colors.black),
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
