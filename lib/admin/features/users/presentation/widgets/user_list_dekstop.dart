import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import 'total_user_card.dart';
import 'user_card.dart';
import 'confirm_delete_dialog.dart';
import 'admin_sidebar.dart';

class UserListDesktop extends StatelessWidget {
  final List<UserEntity> users;

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

                // GRID USER
                Expanded(
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

                      return UserCard(
                        user: user,
                        onDelete: () {
                          showConfirmDeleteDialog(context, user.id);
                        },
                      );
                    },
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
