import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../domain/entities/user_entity.dart';
import 'total_user_card.dart';
import 'user_card.dart';
import 'confirm_delete_dialog.dart';

class UserListTablet extends StatelessWidget {
  final List<User> users;

  const UserListTablet({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // TOTAL USER
          TotalUserCard(totalUser: users.length),
          const SizedBox(height: 16),

          // GRID USER WITH ANIMATION
          Expanded(
            child: AnimationLimiter(
              child: GridView.builder(
                itemCount: users.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3.2,
                ),
                itemBuilder: (context, index) {
                  final user = users[index];

                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    columnCount: 2,
                    duration: const Duration(milliseconds: 400),
                    child: SlideAnimation(
                      verticalOffset: 40.0,
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
      ),
    );
  }
}
