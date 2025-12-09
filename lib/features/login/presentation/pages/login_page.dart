import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../../../../app/home_layout.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailC = TextEditingController();
    final passC = TextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                print(">>> LOGIN SUCCESS — MASUK HOME");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeLayout()),
                );
              }

              if (state is LoginFailure) {
                print(">>> LOGIN FAILED: ${state.message}");
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },

            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: emailC,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: passC,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "Password"),
                  ),

                  const SizedBox(height: 30),

                  state is LoginLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            print(">>> Login button clicked");
                            context.read<LoginBloc>().add(
                              LoginSubmitted(
                                emailC.text.trim(),
                                passC.text.trim(),
                              ),
                            );
                          },
                          child: const Text("Login"),
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
