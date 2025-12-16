import 'package:curesee/app/registrasi/data/data_source/registrasi_remote_data_source.dart';
import 'package:curesee/app/registrasi/data/repositories/registrasi_repository_impl.dart';
import 'package:curesee/app/registrasi/domain/use_case/registrasi_use_case.dart';
import 'package:curesee/app/registrasi/presentation/bloc/registrasi_bloc.dart';
import 'package:curesee/app/registrasi/presentation/pages/registrasi_page.dart';
import 'package:flutter/material.dart';
import 'package:curesee/app/login/presentation/widgets/login_header.dart';
import 'package:curesee/app/login/presentation/widgets/login_form.dart';
import 'package:curesee/app/login/presentation/widgets/login_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailC = TextEditingController();
    final passC = TextEditingController();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFBEE3F8), Color(0xFFFFFFFF)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              const LoginHeader(),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CA6FE),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoginForm(
                      emailController: emailC,
                      passwordController: passC,
                    ),
                    const SizedBox(height: 20),
                    LoginButton(
                      emailController: emailC,
                      passwordController: passC,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Do you have not account?'),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => RegistrasiBloc(
                              RegistrasiUseCase(
                                RegistrasiRepositoryImpl(
                                  DummyRegistrasiRemoteDataSource(),
                                ),
                              ),
                            ),
                            child: const RegistrasiPage(),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Create here',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
              const Text('by KelompokSigma', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
