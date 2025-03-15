import 'package:flutter/material.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/features/home/presentation/widgets/investment_chart.dart';
import 'package:tanami_capital/features/home/presentation/widgets/investment_portfolio.dart';
import 'package:tanami_capital/shared/entities/investment_history_entity.dart';

class InvestmentSummary extends StatelessWidget {
  final List<InvestmentHistoryEntity> investmentHistories;
  final double totalInvestments;
  final double max;
  final double min;
  const InvestmentSummary({
    super.key,
    required this.investmentHistories,
    required this.totalInvestments,
    required this.max,
    required this.min,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.investmentSummary,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: context.h(8)),
        InvestmentPortfolio(totalPortfolioValue: totalInvestments),
        SizedBox(height: context.h(16)),
        InvestmentChart(
          investmentHistories: investmentHistories,
          max: max,
          min: min,
        ),
      ],
    );
  }
}
