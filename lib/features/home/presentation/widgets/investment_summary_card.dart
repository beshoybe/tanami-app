import 'package:flutter/material.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';

class InvestmentSummaryCard extends StatelessWidget {
  final Widget child;
  const InvestmentSummaryCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(
              0xFF606060,
            ).withAlpha((0.08 * 255).toInt()), // 8% opacity
            blurRadius: 27.66,
            offset: const Offset(0, 6.91), // X: 0, Y: 6.91
          ),
        ],
      ),
      padding: EdgeInsets.all(context.w(12)),
      child: child,
    );
  }
}
