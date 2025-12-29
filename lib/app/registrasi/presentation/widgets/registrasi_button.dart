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
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state is RegistrasiLoading
                ? null
                : () {
                    if (nameC.text.isEmpty ||
                        emailC.text.isEmpty ||
                        genderC.text.isEmpty ||
                        ageC.text.isEmpty ||
                        passC.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Semua field wajib diisi ya!'),
                        ),
                      );
                      return;
                    }

                    context.read<RegistrasiBloc>().add(
                      RegistrasiSubmitted(
                        name: nameC.text.trim(),
                        email: emailC.text.trim(),
                        gender: genderC.text.trim(),
                        age: int.parse(ageC.text),
                        password: passC.text.trim(),
                      ),
                    );
                  },
            child: state is RegistrasiLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
                    'Create your account',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
          ),
        );
      },
    );
  }
}
