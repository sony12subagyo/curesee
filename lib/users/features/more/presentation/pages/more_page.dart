import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('More'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFE0E0E0),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildMenuCard(
                      title: 'How to take photo?',
                      onTap: () {
                        print('How to take photo clicked');
                      },
                    ),
                    const SizedBox(height: 12),

                    _buildMenuCard(
                      title:
                          'How is machine learning used in the application?',
                      onTap: () {
                        print('Machine learning clicked');
                      },
                    ),
                    const SizedBox(height: 12),

                    _buildMenuCard(
                      title: 'What is an curesee?',
                      onTap: () {
                        print('What is curesee clicked');
                      },
                    ),
                    const SizedBox(height: 12),

                    _buildMenuCard(
                      title: 'Who should use Cursee?',
                      onTap: () {
                        print('Who should use Cursee clicked');
                      },
                    ),
                    const SizedBox(height: 12),

                    _buildMenuCard(
                      title: 'How to edit account?',
                      onTap: () {
                        print('Edit account clicked');
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'by Kelompoksigma',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== MENU CARD =====
  Widget _buildMenuCard({
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16, // ⬅️ tambah dikit biar lebih lega
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
