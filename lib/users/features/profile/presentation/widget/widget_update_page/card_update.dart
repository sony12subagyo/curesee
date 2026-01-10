import 'dart:io';
import 'package:curesee/users/features/profile/domain/entities/profile.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:curesee/users/features/profile/presentation/bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCardUpdate extends StatefulWidget {
  final Profile profile;

  const ProfileCardUpdate({super.key, required this.profile});

  @override
  State<ProfileCardUpdate> createState() => _ProfileCardUpdateState();
}

class _ProfileCardUpdateState extends State<ProfileCardUpdate> {
  File? selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (!mounted) return;

    if (image != null) {
      final file = File(image.path);
      setState(() => selectedImage = file);

      context.read<ProfileBloc>().add(UploadAvatarEvent(file));
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatarProvider = selectedImage != null
        ? FileImage(selectedImage!)
        : (widget.profile.avatarUrl.isNotEmpty
              ? NetworkImage(widget.profile.avatarUrl)
              : null);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: avatarProvider as ImageProvider?,
                child: avatarProvider == null
                    ? const Icon(Icons.person, size: 40)
                    : null,
              ),

              // tombol edit
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.edit, size: 16, color: Colors.white),
                  onPressed: _pickImage,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            widget.profile.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Text(widget.profile.email),
        ],
      ),
    );
  }
}
