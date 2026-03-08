import 'package:curesee/app/registrasi/domain/entities/registrasi_entitity.dart';
import 'package:curesee/app/registrasi/presentation/bloc/regisrasi_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/registrasi_bloc.dart';
import '../bloc/registrasi_state.dart';

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
                    if (!formKey.currentState!.validate()) return;

                    if (gender.value == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pilih gender terlebih dahulu'),
                        ),
                      );
                      return;
                    }

                    final age = int.tryParse(ageC.text);
                    if (age == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Umur harus berupa angka'),
                        ),
                      );
                      return;
                    }

                    context.read<RegistrasiBloc>().add(
                      RegistrasiSubmitted(
                        RegistrasiEntity(
                          name: nameC.text.trim(),
                          email: emailC.text.trim(),
                          gender: gender.value!,
                          age: age,
                          password: passC.text.trim(),
                        ),
                      ),
                    );
                  },
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Create your account',style: TextStyle(color: Color.fromARGB(255, 0, 128, 255)),),
          ),
        );
      },
    );
  }
}
