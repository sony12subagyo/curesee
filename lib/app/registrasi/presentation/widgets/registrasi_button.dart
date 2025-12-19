import 'package:curesee/app/registrasi/presentation/bloc/regisrasi_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/registrasi_bloc.dart';
import '../bloc/registrasi_state.dart';

class RegistrasiButton extends StatelessWidget {
  final TextEditingController nameC;
  final TextEditingController emailC;
  final TextEditingController genderC;
  final TextEditingController ageC;
  final TextEditingController passC;

  const RegistrasiButton({
    super.key,
    required this.nameC,
    required this.emailC,
    required this.genderC,
    required this.ageC,
    required this.passC,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrasiBloc, RegistrasiState>(
      builder: (context, state) {
        final isLoading = state is RegistrasiLoading;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A74FF),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: isLoading
                ? null
                : () {
                    if (nameC.text.isEmpty ||
                        emailC.text.isEmpty ||
                        genderC.text.isEmpty ||
                        ageC.text.isEmpty ||
                        passC.text.isEmpty) {
                      _showMessage(context, 'Semua field wajib diisi');
                      return;
                    }

                    context.read<RegistrasiBloc>().add(
                      RegistrasiSubmitted(
                        name: nameC.text.trim(),
                        email: emailC.text.trim(),
                        gender: genderC.text.trim(),
                        age: int.tryParse(ageC.text) ?? 0,
                        password: passC.text.trim(),
                      ),
                    );
                  },
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'Create your account',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
          ),
        );
      },
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
