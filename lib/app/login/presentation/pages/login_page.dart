import 'package:curesee/app/registrasi/presentation/pages/registrasi_page.dart';
import 'package:flutter/material.dart';
import 'package:curesee/responsive_desain/responsive_layout.dart';
import '../widgets/login_header.dart';
import '../widgets/login_form.dart';
import '../widgets/login_button.dart';

// TETAP StatelessWidget
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailC = TextEditingController();
    final passC = TextEditingController();

    Widget content(double maxWidth) => Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            children: [
              const SizedBox(height: 80),
              const LoginHeader(),
              const SizedBox(height: 24),

              // animasi fade dan slide
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 400),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, (1 - value) * 30),
                      child: child,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CA6FE),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 10),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoginForm(
                        emailController: emailC,
                        passwordController: passC,
                      ),

                      const SizedBox(height: 12),

                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const RegistrasiPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Sign up now!",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 250),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      LoginButton(
                        emailController: emailC,
                        passwordController: passC,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
              const Text('by KelompokSigma', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFBEE3F8), Colors.white],
          ),
        ),
        child: ResponsiveLayout(
          mobile: content(double.infinity),
          tablet: content(480),
          desktop: content(420),
        ),
      ),
    );
  }
}
