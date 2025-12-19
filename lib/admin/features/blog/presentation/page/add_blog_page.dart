import 'package:flutter/material.dart';

class AddBlogPage extends StatelessWidget {
  const AddBlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1EA3FF),
              Color(0xFF7BC9FF),
              Color(0xFFEAF7FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // _buildHeader(context),
              // const SizedBox(height: 16),

              // _buildImagePickerCard(),
              // const SizedBox(height: 16),

              // _buildDescriptionCard(),

              // const Spacer(),

              // _buildActionButtons(),
              // const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}