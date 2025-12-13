import 'package:curesee/users/features/beranda/presentation/widgets/card_detail_page..dart';
import 'package:flutter/material.dart';


class DetailInformationPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const DetailInformationPage({
    super.key,
    this.title = "Informasi",
    this.description =
        "Skin diseases often show visible signs such as unusual discoloration, rashes, itching, dryness, swelling, or texture changes. These symptoms may indicate irritation or infection.",
    this.imageUrl = "https://picsum.photos/500/300",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1EA3FF),
              Color(0xFF7BC9FF),
              Color(0xFFEAF7FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _Header(title: title),

              const SizedBox(height: 12),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CardDetail(
                    imageUrl: imageUrl,
                    description: description,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _Header extends StatelessWidget {
  final String title;

  const _Header({required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          
          SizedBox(
            width: 56,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.only(left: 12),
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F0F0),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.blue),
              ),
            ),
          ),

          // CENTER (Title)
          Expanded(
            child: Text(
              title.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 56),
        ],
      ),
    );
  }
}
