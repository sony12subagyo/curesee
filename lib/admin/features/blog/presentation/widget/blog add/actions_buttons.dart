import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blog_bloc.dart';
import '../../bloc/blog_event.dart';
import '../../bloc/blog_state.dart';

import '../../../view_image/add_image_bloc.dart';
import 'description_page.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogBloc, BlogState>(
      listener: (context, state) {
        if (state is BlogSuccess) {
          debugPrint('🟢 UI: BlogSuccess → POP PAGE');
          Navigator.pop(context);
        }
        if (state is BlogFailure) {
          debugPrint('❌ UI: BlogFailure → ${state.message}');
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state is BlogLoading
              ? null
              : () {
                  debugPrint('🟡 BUTTON: Simpan diklik');

                  final image =
                      context.read<AddImageBloc>().state.image;

                  debugPrint(
                      '🟡 title: ${BlogFormController.title.text}');
                  debugPrint(
                      '🟡 desc: ${BlogFormController.description.text}');
                  debugPrint('🟡 image null? ${image == null}');

                  if (image == null) {
                    debugPrint('❌ IMAGE NULL – CANCEL');
                    return;
                  }

                  context.read<BlogBloc>().add(
                        CreateBlogRequested(
                          title:
                              BlogFormController.title.text.trim(),
                          description: BlogFormController
                              .description.text
                              .trim(),
                          image: image,
                        ),
                      );

                  debugPrint(
                      '🟢 EVENT CreateBlogRequested DIKIRIM');
                },
          child: state is BlogLoading
              ? const CircularProgressIndicator()
              : const Text('Simpan'),
        );
      },
    );
  }
}
