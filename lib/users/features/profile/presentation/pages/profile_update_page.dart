import 'package:curesee/users/features/profile/domain/entities/profil.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_event.dart';
import 'package:curesee/users/features/profile/presentation/widget/profile_card_update.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileUpdatePage extends StatelessWidget {
  final Profile profile;
  const ProfileUpdatePage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final blocProfil = context.read<ProfileBloc>();

    final namaCtrl = TextEditingController(text: profile.name);
    final genderCtrl = TextEditingController(text: profile.gender);
    final ageCtrl = TextEditingController(text: profile.age.toString());
    final emailCtrl = TextEditingController(text: profile.email);

    return Scaffold(
      appBar: AppBar(title: const Text('Update Profile')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ProfileCardUpdate(profile: profile),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: namaCtrl,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    TextField(
                      controller: genderCtrl,
                      decoration: const InputDecoration(labelText: 'Gender'),
                    ),
                    TextField(
                      controller: ageCtrl,
                      decoration: const InputDecoration(labelText: 'Age'),
                    ),
                    TextField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                  ],
                ),
              ),
            ),

            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text("Simpan"),
                  onPressed: () {
                    if (namaCtrl.text.isEmpty ||
                        genderCtrl.text.isEmpty ||
                        ageCtrl.text.isEmpty ||
                        emailCtrl.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Semua field wajib diisi!"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    blocProfil.add(
                      UpdateProfileEvent(
                        Profile(
                          id: profile.id,
                          name: namaCtrl.text,
                          gender: genderCtrl.text,
                          age: int.parse(ageCtrl.text),
                          email: emailCtrl.text,
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
