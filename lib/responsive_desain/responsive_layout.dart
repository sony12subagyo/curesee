import 'package:flutter/material.dart';
import 'responsive_helper.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (ResponsiveHelper.isDesktop(context)) return desktop;
    if (ResponsiveHelper.isTablet(context)) return tablet;
    return mobile;
  }
}
