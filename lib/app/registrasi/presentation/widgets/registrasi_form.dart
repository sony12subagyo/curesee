import 'package:flutter/material.dart';

class RegistrasiForm extends StatefulWidget {
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
  State<RegistrasiForm> createState() => _RegistrasiFormState();
}

class _RegistrasiFormState extends State<RegistrasiForm> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _input('Name', widget.nameC),
        _input('Email', widget.emailC),
        _input('Gender', widget.genderC),
        _input('Age', widget.ageC, isNumber: true),
        _passwordInput(),
      ],
    );
  }

  Widget _input(
    String label,
    TextEditingController c, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
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
    );
  }

  Widget _passwordInput() {
    return TextField(
      controller: widget.passC,
      obscureText: _obscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Enter your password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => _obscure = !_obscure),
        ),
      ),
    );
  }
}
