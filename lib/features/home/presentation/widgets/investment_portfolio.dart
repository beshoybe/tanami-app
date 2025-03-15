import 'package:flutter/material.dart';
import 'package:tanami_capital/config/extensions.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/features/home/presentation/widgets/investment_summary_card.dart';
import 'package:tanami_capital/gen/assets/assets.gen.dart';

class InvestmentPortfolio extends StatelessWidget {
  final double totalPortfolioValue;
  const InvestmentPortfolio({super.key, required this.totalPortfolioValue});

  @override
  Widget build(BuildContext context) {
    return InvestmentSummaryCard(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                context.tr.totalPortfolio,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Text(
                context.toArabicNumber(
                  '\$${(totalPortfolioValue.toStringAsFixed(2))}',
                ),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: context.h(12)),
          Row(
            children: [
              Assets.svg.chart.svg(width: context.w(80)),
              Spacer(),
              Assets.svg.arrowup.svg(height: context.h(26)),
            ],
          ),
        ],
      ),
    );
  }
}
