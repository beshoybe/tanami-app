import 'package:flutter/material.dart';
import 'package:tanami_capital/shared/widgets/bottom_nav.dart';

class ScreenWithNavbar extends StatelessWidget {
  final Widget child;
  const ScreenWithNavbar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child,
          Positioned(bottom: 0, left: 0, right: 0, child: BottomNav()),
        ],
      ),
    );
  }
}
