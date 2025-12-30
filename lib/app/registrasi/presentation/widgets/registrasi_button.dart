import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/registrasi_bloc.dart';
import '../bloc/registrasi_state.dart';
import '../bloc/regisrasi_event.dart';

class RegistrasiButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameC;
  final TextEditingController emailC;
  final TextEditingController ageC;
  final TextEditingController passC;
  final ValueNotifier<String?> gender;

  const RegistrasiButton({
    super.key,
    required this.formKey,
    required this.nameC,
    required this.emailC,
    required this.ageC,
    required this.passC,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrasiBloc, RegistrasiState>(
      builder: (context, state) {
        final isLoading = state is RegistrasiLoading;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    // ✅ VALIDASI FORM
                    if (!formKey.currentState!.validate()) return;

                    // ✅ VALIDASI GENDER
                    if (gender.value == null) {
                      _showMessage(context, 'Gender wajib dipilih');
                      return;
                    }

                    context.read<RegistrasiBloc>().add(
                      RegistrasiSubmitted(
                        name: nameC.text.trim(),
                        email: emailC.text.trim(),
                        gender: gender.value!, // male / female
                        age: int.parse(ageC.text),
                        password: passC.text.trim(),
                      ),
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A74FF),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
