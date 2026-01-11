import 'package:flutter/material.dart';
import 'package:curesee/admin/features/blog/presentation/page/blog_page.dart';
import 'package:curesee/app/login/presentation/pages/login_page.dart';

class AdminSidebar extends StatelessWidget {
  final int activeIndex;

  const AdminSidebar({
    super.key,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 32),

          // LOGO
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.favorite, color: Colors.blue),
              SizedBox(width: 6),
              Text(
                'CureSee',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // MENU BLOG
          _menuItem(
            context,
            icon: Icons.article,
            title: 'Blog',
            active: activeIndex == 0,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const BlogPage()),
              );
            },
          ),

          // MENU USER
          _menuItem(
            context,
            icon: Icons.people,
            title: 'Account',
            active: activeIndex == 1,
          ),

          const Spacer(),

          // LOGOUT
          _menuItem(
            context,
            icon: Icons.logout_rounded,
            title: 'Logout',
            danger: true,
            onTap: () => _showLogoutDialog(context),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _menuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    bool active = false,
    bool danger = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: active ? Colors.blue.shade50 : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: danger ? Colors.red : Colors.blue),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
                color: danger ? Colors.red : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
