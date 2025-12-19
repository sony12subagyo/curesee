import 'package:curesee/admin/features/blog/presentation/page/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../../../navigation/home_layout.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          if (state.role == 'user') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeLayout()),
            );
          } else if (state.role == 'admin') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const BlogPage()),
            );
          }
        }

        if (state is LoginFailure) {
          _showMessage(context, state.message);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state is LoginLoading
                ? null
                : () {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    if (email.isEmpty && password.isEmpty) {
                      _showMessage(context, 'Email dan sandi harap diisi');
                      return;
                    }

                    if (email.isEmpty) {
                      _showMessage(context, 'Email harap diisi');
                      return;
                    }

                    if (password.isEmpty) {
                      _showMessage(context, 'Sandi harap diisi');
                      return;
                    }
                    context.read<LoginBloc>().add(
                      LoginSubmitted(email, password),
                    );
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
