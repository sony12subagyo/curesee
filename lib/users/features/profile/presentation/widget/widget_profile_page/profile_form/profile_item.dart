import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(width: 4),
            Icon(icon, color: Colors.black, size: 18),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontSize: 14)),
            const Spacer(),

            SizedBox(
              width: 48,
              height: 48,
              child: trailing != null
                  ? IconButton(
                      icon: trailing!,
                      onPressed: onTap, // 🔥 penting
                      padding: EdgeInsets.zero,
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
