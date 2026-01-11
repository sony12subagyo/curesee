import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';

void showConfirmDeleteDialog(BuildContext context, int userId) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Hapus User'),
      content: const Text('Apakah Anda yakin ingin menghapus user ini?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            context.read<UserBloc>().add(DeleteUserRequested(userId));
            Navigator.pop(context);
          },
          child: const Text('Hapus'),
        ),
      ],
    ),
  );
}
