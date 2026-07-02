import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  static const double mobileWidth = 475.0;
  static const double tabletWidth = 768.0;
  static const double desktopWidth = 1386.0;

  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    required this.mobile,
    required this.tablet,
    required this.desktop,
    super.key,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletWidth;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletWidth &&
      MediaQuery.of(context).size.width < desktopWidth;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopWidth;

  Widget _buildWithSelectionArea(Widget child) {
    return child;
  }

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) {
      return _buildWithSelectionArea(desktop);
    } else if (isTablet(context)) {
      return _buildWithSelectionArea(tablet);
    } else {
      return _buildWithSelectionArea(mobile);
    }
  }
}
