import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Email', style: TextStyle(color: Colors.white)),
        const SizedBox(height: 6),
        _inputField(emailController, hint: 'Enter your email', isPass: false),
        const SizedBox(height: 12),
        const Text('Password', style: TextStyle(color: Colors.white)),
        const SizedBox(height: 6),
        _inputField(
          passwordController,
          hint: 'Enter your password',
          isPass: true,
        ),
      ],
    );
  }

  Widget _inputField(
    TextEditingController controller, {
    required String hint,
    required bool isPass,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPass,
      keyboardType: isPass ? TextInputType.text : TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
