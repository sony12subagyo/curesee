import 'package:curesee/users/features/profile/presentation/pages/profil_page.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final ImageProvider avatar;

  const CustomHeader({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 1, 132, 255),
            Color.fromARGB(255, 0, 123, 245),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false, // ⭐ penting biar ga terlalu tinggi
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 28),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilPage(),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 28,
                  backgroundImage: avatar,
                ),
              ),
              const SizedBox(width: 12),

              Expanded( // ⭐ cegah overflow horizontal & vertical
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // ⭐ kunci auto-height
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color.fromARGB(179, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
