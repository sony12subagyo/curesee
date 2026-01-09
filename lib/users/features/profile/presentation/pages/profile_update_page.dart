import 'package:curesee/users/features/profile/domain/entities/profile.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_event.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_state.dart';
import 'package:curesee/users/features/profile/presentation/widget/gender_label.dart';
import 'package:curesee/users/features/profile/presentation/widget/widget_update_page/input_style.dart';
import 'package:curesee/users/features/profile/presentation/widget/widget_update_page/card_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileUpdatePage extends StatefulWidget {
  final Profile profile;
  const ProfileUpdatePage({super.key, required this.profile});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController namaCtrl;
  late TextEditingController ageCtrl;
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    namaCtrl = TextEditingController(text: widget.profile.name);
    ageCtrl = TextEditingController(
      text: widget.profile.age == 0 ? "" : widget.profile.age.toString(),
    );
    selectedGender = widget.profile.gender.isEmpty
        ? "L"
        : widget.profile.gender;
  }

  @override
  void dispose() {
    namaCtrl.dispose();
    ageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          Navigator.pop(context); // hanya tutup jika sukses dari API
        }

        if (state is ProfileError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 128, 255),
          elevation: 0,
          title: const Text(
            "Edit Profil",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              ProfileCardUpdate(profile: widget.profile),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 128, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== NAMA =====
                    const Text(
                      "Nama",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: namaCtrl,
                      decoration: FormStyles.input,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return "Nama tidak boleh kosong";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ===== UMUR =====
                    const Text(
                      "Umur",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: ageCtrl,
                      keyboardType: TextInputType.number,
                      decoration: FormStyles.input,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return "Umur tidak boleh kosong";
                        }
                        final age = int.tryParse(v);
                        if (age == null || age <= 0) {
                          return "Umur tidak valid";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ===== GENDER =====
                    ListTileTheme(
                      dense: true,
                      horizontalTitleGap: 1,
                      child: Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              value: "L",
                              groupValue: selectedGender,
                              activeColor: Colors.white,
                              title: Text(
                                genderLabel("L"),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                              onChanged: (v) {
                                if (v != null) {
                                  setState(() => selectedGender = v);
                                }
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              value: "P",
                              groupValue: selectedGender,
                              activeColor: Colors.white,
                              title: Text(
                                genderLabel("P"),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                              onChanged: (v) {
                                if (v != null) {
                                  setState(() => selectedGender = v);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ===== BUTTON SIMPAN =====
                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          // 🔥 VALIDASI FORM DI SINI
                          if (!_formKey.currentState!.validate()) return;

                          context.read<ProfileBloc>().add(
                            UpdateProfileEvent(
                              Profile(
                                id: widget.profile.id,
                                name: namaCtrl.text.trim(),
                                gender: selectedGender ?? "L",
                                age: int.parse(ageCtrl.text),
                                email: widget.profile.email,
                                avatarUrl: widget.profile.avatarUrl,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Simpan",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
