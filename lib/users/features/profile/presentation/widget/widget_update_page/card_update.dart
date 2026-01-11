import 'dart:io';
import 'package:curesee/users/features/profile/domain/entities/profile.dart';
import 'package:flutter/material.dart';

class ProfileCardUpdate extends StatefulWidget {
  final Profile profile;

  const ProfileCardUpdate({super.key, required this.profile});

  @override
  State<ProfileCardUpdate> createState() => _ProfileCardUpdateState();
}

class _ProfileCardUpdateState extends State<ProfileCardUpdate> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor:
                    Colors.blue.shade100, // sesuaikan dengan theme CureSee
                child: const Icon(Icons.person, size: 40, color: Colors.blue),
              ),

              // tombol edit
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            widget.profile.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Text(widget.profile.email),
        ],
      ),
    );
  }
}
