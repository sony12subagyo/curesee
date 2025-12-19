import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curesee/responsive_desain/responsive_layout.dart';

import '../bloc/registrasi_bloc.dart';
import '../bloc/registrasi_state.dart';
import '../widgets/registrasi_form.dart';
import '../widgets/registrasi_button.dart';
import '../widgets/registrasi_header.dart';

class RegistrasiPage extends StatelessWidget {
  const RegistrasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameC = TextEditingController();
    final emailC = TextEditingController();
    final genderC = TextEditingController();
    final ageC = TextEditingController();
    final passC = TextEditingController();

    Widget content(double maxWidth) => Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const RegistrasiHeader(),
              const SizedBox(height: 24),

              /// CARD FORM
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CA6FE),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    RegistrasiForm(
                      nameC: nameC,
                      emailC: emailC,
                      genderC: genderC,
                      ageC: ageC,
                      passC: passC,
                    ),
                    const SizedBox(height: 20),
                    RegistrasiButton(
                      nameC: nameC,
                      emailC: emailC,
                      genderC: genderC,
                      ageC: ageC,
                      passC: passC,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              const Text('by KelompokSigma', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      body: BlocListener<RegistrasiBloc, RegistrasiState>(
        listener: (context, state) {
          if (state is RegistrasiSuccess) {
            Navigator.pop(context);
          }
          if (state is RegistrasiFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFBEE3F8), Colors.white],
            ),
          ),
          child: ResponsiveLayout(
            mobile: content(double.infinity),
            tablet: content(520),
            desktop: content(460),
          ),
        ),
      ),
    );
  }
}
