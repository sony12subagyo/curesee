import 'dart:async';
import 'package:flutter/material.dart';
import 'package:curesee/app/login/presentation/pages/login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _index = 0;
  Timer? _timer;

  final List<_OnboardItem> items = [
    _OnboardItem(
      image: 'https://images.unsplash.com/photo-1580281657521-7a64f4f8d8b2',
      title: 'Welcome To CureSee',
      desc:
          'Curesee is an intelligent skin-scanning application that helps you identify skin conditions quickly and accurately.',
    ),
    _OnboardItem(
      image: 'https://images.unsplash.com/photo-1580281658629-85e3c5d7eaf6',
      title: 'Scan Your Skin',
      desc:
          'Simply take a photo, let the system analyze it, and receive clear insights.',
    ),
    _OnboardItem(
      image: 'https://images.unsplash.com/photo-1588776814546-1ffcf47267b0',
      title: 'Personalized Care',
      desc:
          'Get personalized care recommendations designed to support your skin’s health every day.',
    ),
  ];

  @override
  void initState() {
    super.initState();

    /// 🔥 AUTO SLIDE TIAP 5 DETIK
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_pageController.hasClients) {
        _index = (_index + 1) % items.length;
        _pageController.animateToPage(
          _index,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1200;

    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND IMAGE
          PageView.builder(
            controller: _pageController,
            itemCount: items.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (_, i) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                child: Image.network(
                  items[i].image,
                  key: ValueKey(items[i].image),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            },
          ),

          /// OVERLAY
          Container(color: Colors.black.withOpacity(0.45)),

          /// CONTENT
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 700 : double.infinity,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        items[_index].title,
                        key: ValueKey(items[_index].title),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        items[_index].desc,
                        key: ValueKey(items[_index].desc),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    /// DOT INDICATOR
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        items.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _index == i ? 14 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _index == i ? Colors.white : Colors.white54,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    /// BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A74FF),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardItem {
  final String image;
  final String title;
  final String desc;

  _OnboardItem({required this.image, required this.title, required this.desc});
}
