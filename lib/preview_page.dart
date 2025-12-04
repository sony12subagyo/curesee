import 'dart:io';
import 'package:flutter/material.dart';

class PreviewPage extends StatelessWidget {
  final String imagePath;

  PreviewPage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Foto"),
      ),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
