import 'package:flutter/material.dart';

class RegistrasiForm extends StatelessWidget {
  final TextEditingController nameC;
  final TextEditingController emailC;
  final TextEditingController genderC;
  final TextEditingController ageC;
  final TextEditingController passC;

  const RegistrasiForm({
    super.key,
    required this.nameC,
    required this.emailC,
    required this.genderC,
    required this.ageC,
    required this.passC,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Create account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        _input('Name', nameC),
        _input('Email', emailC),
        _input('Gender', genderC),
        _input('Age', ageC, isNumber: true),
        _input('Password', passC, isPassword: true),
      ],
    );
  }

  Widget _input(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Enter your $label',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
