import 'package:curesee/admin/features/blog/presentation/widget/blog%20add/actions_buttons.dart';
import 'package:curesee/admin/features/blog/presentation/widget/blog%20add/add_image.dart';
import 'package:curesee/admin/features/blog/presentation/widget/blog%20add/description_page.dart';

import 'package:curesee/admin/features/blog/presentation/widget/blog%20add/information_header_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/repository/image_repository_impl.dart';
import '../../domain/usecase/add_image_usecase.dart';
import '../bloc/add_image_bloc.dart';

class AddBlogPage extends StatelessWidget {
  const AddBlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddImageBloc>(
      create: (_) => AddImageBloc(
        AddImageUsecase(
          ImageRepositoryImpl(ImagePicker()),
        ),
      ),
      child: Scaffold(
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
              children: const [
                InformationHeaderAdd(),
                SizedBox(height: 16),

                ImagePickerCard(), // ✅ SEKARANG AMAN
                SizedBox(height: 16),

                DescriptionCard(),

                Spacer(),

                ActionButtons(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
