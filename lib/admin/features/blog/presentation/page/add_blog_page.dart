import 'package:curesee/admin/features/blog/image/add_image_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

import 'package:curesee/admin/features/blog/core/network/admin_dio.dart';

import '../../image/add_image_bloc.dart';
import '../../image/image_repository_impl.dart';

import '../bloc/blog_bloc.dart';
import '../../data/datasource/blog_remote_datasource.dart';
import '../../data/repository/blog_repository_impl.dart';

import '../widget/blog add/information_header_page.dart';
import '../widget/blog add/add_image.dart';
import '../widget/blog add/description_page.dart';
import '../widget/blog add/actions_buttons.dart';

class AddBlogPage extends StatelessWidget {
  const AddBlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Dio>(
      future: AdminDio.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        final dio = snapshot.data!;

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AddImageBloc(
                AddImageUsecase(
                  ImageRepositoryImpl(ImagePicker()),
                ),
              ),
            ),
            BlocProvider(
              create: (_) => BlogBloc(
                BlogRepositoryImpl(
                  BlogRemoteDatasource(dio),
                ),
              ),
            ),
          ],
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView( // 🔥 FIX OVERFLOW SEKALIAN
                child: Column(
                  children: const [
                    InformationHeaderAdd(),
                    SizedBox(height: 16),
                    ImagePickerCard(),
                    SizedBox(height: 16),
                    DescriptionCard(),
                    SizedBox(height: 24),
                    ActionButtons(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
