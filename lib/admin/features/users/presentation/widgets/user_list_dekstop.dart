import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../domain/entities/user_entity.dart';
import 'total_user_card.dart';
import 'user_card.dart';
import 'confirm_delete_dialog.dart';
import 'admin_sidebar.dart';

class UserListDesktop extends StatelessWidget {
  final List<User> users;

  const UserListDesktop({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ===== SIDEBAR =====
        const AdminSidebar(activeIndex: 1),

        // ===== CONTENT =====
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Information Account User',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),

                // TOTAL USER
                TotalUserCard(totalUser: users.length),
                const SizedBox(height: 24),

                // GRID USER WITH ANIMATION
                Expanded(
                  child: AnimationLimiter(
                    child: GridView.builder(
                      itemCount: users.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 3.5,
                      ),
                      itemBuilder: (context, index) {
                        final user = users[index];

                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: 3,
                          duration: const Duration(milliseconds: 350),
                          child: SlideAnimation(
                            verticalOffset: 30.0,
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
          ),
        ),
      ],
    );
  }
}
