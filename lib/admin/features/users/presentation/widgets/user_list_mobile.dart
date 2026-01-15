import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../domain/entities/user_entity.dart';
import 'total_user_card.dart';
import 'user_card.dart';
import 'confirm_delete_dialog.dart';

class UserListMobile extends StatelessWidget {
  final List<User> users;

  const UserListMobile({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TOTAL USER
        TotalUserCard(totalUser: users.length),

        // LIST USER WITH ANIMATION
        Expanded(
          child: AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 400),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: UserCard(
                        user: user,
                        onDelete: () {
                          showConfirmDeleteDialog(context, user.id);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
