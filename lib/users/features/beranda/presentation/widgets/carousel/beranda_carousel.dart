import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BerandaCarousel extends StatelessWidget {
  BerandaCarousel({super.key});

  final List<String> imageList = [
    'https://picsum.photos/id/1015/800/400',
    'https://picsum.photos/id/1021/800/400',
    'https://picsum.photos/id/1035/800/400',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 160,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        enlargeCenterPage: true,
        viewportFraction: 0.9,
      ),
      items: imageList.map((imageUrl) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16), // ✅ PINDAH KE SINI
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              const Positioned(
                left: 16,
                bottom: 16,
                child: Text(
                  'Highlight Curesee',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
