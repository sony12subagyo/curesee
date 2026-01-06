import 'package:flutter/material.dart';

class RegistrasiForm extends StatefulWidget {
  final TextEditingController nameC;
  final TextEditingController emailC;
  final TextEditingController ageC;
  final TextEditingController passC;
  final ValueNotifier<String?> gender;

  const RegistrasiForm({
    super.key,
    required this.nameC,
    required this.emailC,
    required this.ageC,
    required this.passC,
    required this.gender,
  });

  @override
  State<RegistrasiForm> createState() => _RegistrasiFormState();
}

class _RegistrasiFormState extends State<RegistrasiForm> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      // ✅ TIDAK ADA FORM
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _field(
          label: 'Name',
          controller: widget.nameC,
          validator: (v) =>
              v == null || v.length < 3 ? 'Nama minimal 3 huruf' : null,
        ),

        _field(
          label: 'Email',
          controller: widget.emailC,
          validator: (v) {
            if (v == null || !v.contains('@')) {
              return 'Email tidak valid';
            }
            return null;
          },
        ),

        const SizedBox(height: 8),
        const Text('Gender', style: TextStyle(color: Colors.white)),

        ValueListenableBuilder<String?>(
          valueListenable: widget.gender,
          builder: (_, value, __) => Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: const Text(
                    'Laki-laki',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: 'male',
                  groupValue: value,
                  onChanged: (v) => widget.gender.value = v,
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: const Text(
                    'Perempuan',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: 'female',
                  groupValue: value,
                  onChanged: (v) => widget.gender.value = v,
                ),
              ),
            ],
          ),
        ),

        _field(
          label: 'Age',
          controller: widget.ageC,
          keyboardType: TextInputType.number,
          validator: (v) =>
              int.tryParse(v ?? '') == null ? 'Umur tidak valid' : null,
        ),

        _passwordField(),
      ],
    );
  }

  Widget _field({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: widget.passC,
      obscureText: _obscure,
      validator: (v) =>
          v == null || v.length < 6 ? 'Password minimal 6 karakter' : null,
      decoration: InputDecoration(
        labelText: 'Password',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => _obscure = !_obscure),
        ),
      ),
    );
  }
}
