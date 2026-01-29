import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

import '../../../navigation/home_layout.dart';
import 'package:curesee/admin/features/blog/presentation/page/blog_page.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  bool _isAdminEmail(String email) {
    return email.endsWith('@curesee.com');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        // if (state is LoginSuccess) {
        //   if (state.isAdmin) {
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(builder: (_) => const BlogPage()),
        //     );
        //   } else {
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(builder: (_) => const HomeLayout()),
        //     );
        //   }
        // }

if (state is LoginSuccess) {
  if (state.isAdmin) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const BlogPage()),
    );
  } else {
    // 🔥 TUNGGU 300ms BIAR BACKEND SELESAI SIMPAN
    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeLayout()),
      );
    });
  }
}


        if (state is LoginFailure) {
          _showMessage(context, state.message);
        }
      },
      builder: (context, state) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.0, end: 1.0),
          duration: const Duration(milliseconds: 120),
          builder: (context, scale, child) {
            return Transform.scale(scale: scale, child: child);
          },
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state is LoginLoading
                  ? null
                  : () {
                      // animasi tekan animasi implincit
                      // efek visual
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        _showMessage(context, 'Email dan password wajib diisi');
                        return;
                      }

                      if (_isAdminEmail(email)) {
                        context.read<LoginBloc>().add(
                          LoginAdminPressed(email, password),
                        );
                      } else {
                        context.read<LoginBloc>().add(
                          LoginUserPressed(email, password),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: const Color(0xFF0A74FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: state is LoginLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Login Now',
                      style: TextStyle(color: Colors.white),
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
