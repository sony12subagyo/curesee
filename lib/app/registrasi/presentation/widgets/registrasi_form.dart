import 'package:flutter/material.dart';

class RegistrasiForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameC;
  final TextEditingController emailC;
  final TextEditingController ageC;
  final TextEditingController passC;
  final ValueNotifier<String?> gender;

  const RegistrasiForm({
    super.key,
    required this.formKey,
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
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// NAME
          _field(
            label: 'Name',
            controller: widget.nameC,
            validator: (v) {
              if (v == null || v.trim().length < 3) {
                return 'Nama minimal 3 huruf';
              }
              return null;
            },
          ),

          /// EMAIL
          _field(
            label: 'Email',
            controller: widget.emailC,
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.length < 8) {
                return 'Email minimal 8 karakter';
              }
              if (!v.contains('@')) {
                return 'Format email tidak valid';
              }
              return null;
            },
          ),

          /// GENDER (RADIO)
          const Text('Gender', style: TextStyle(color: Colors.white)),
          ValueListenableBuilder<String?>(
            valueListenable: widget.gender,
            builder: (_, value, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile(
                    title: const Text('Laki-laki'),
                    value: 'male',
                    groupValue: value,
                    onChanged: (v) => widget.gender.value = v,
                  ),
                  RadioListTile(
                    title: const Text('Perempuan'),
                    value: 'female',
                    groupValue: value,
                    onChanged: (v) => widget.gender.value = v,
                  ),
                  if (value == null)
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        'Gender wajib dipilih',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              );
            },
          ),

          /// AGE
          _field(
            label: 'Age',
            controller: widget.ageC,
            keyboardType: TextInputType.number,
            validator: (v) {
              final age = int.tryParse(v ?? '');
              if (age == null || age < 10) {
                return 'Umur minimal 10 tahun';
              }
              return null;
            },
          ),

          /// PASSWORD
          _passwordField(),
        ],
      ),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: widget.passC,
        obscureText: _obscure,
        validator: (v) {
          if (v == null || v.length < 6) {
            return 'Password minimal 6 karakter';
          }
          return null;
        },
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
      ),
    );
  }
}
