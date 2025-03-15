import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tanami_capital/config/extensions.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/features/home/presentation/widgets/investment_summary_card.dart';
import 'package:tanami_capital/shared/entities/investment_history_entity.dart';

class InvestmentChart extends StatelessWidget {
  final List<InvestmentHistoryEntity> investmentHistories;
  final double max;
  final double min;
  InvestmentChart({
    super.key,
    required this.investmentHistories,
    required this.max,
    required this.min,
  }) {
    for (var history in investmentHistories) {
      final month = history.month.substring(0, 3);
      profit[month] = history.profit;
      loss[month] = history.loss;
    }
  }

  final profit = {};
  final loss = {};

  @override
  Widget build(BuildContext context) {
    return InvestmentSummaryCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.toArabicNumber(context.tr.thisMonth),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: context.appTheme.normal,
            ),
          ),
          SizedBox(height: context.w(8)),
          SizedBox(
            width: double.infinity,
            height: context.h(150),
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,

              primaryXAxis: CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
              ),

              primaryYAxis: NumericAxis(
                majorGridLines: MajorGridLines(width: 0),
                minimum: (min - 0.1 * (max - min)).clamp(0, double.infinity),
                maximum: max + 0.1 * (max - min),
                interval: (max - min) / 4,
              ),

              series: <CartesianSeries<_ChartData, String>>[
                ColumnSeries<_ChartData, String>(
                  spacing: 0.1,

                  dataSource:
                      profit.entries
                          .map((e) => _ChartData(e.key, e.value))
                          .toList(),
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: context.tr.profit,
                  color: Color(0xff002F0F).withAlpha((0.6 * 255).toInt()),
                ),
                ColumnSeries<_ChartData, String>(
                  spacing: 0.1,
                  dataSource:
                      loss.entries
                          .map((e) => _ChartData(e.key, e.value))
                          .toList(),
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: context.tr.loss,
                  color: Color(0xffD91F1F),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: context.w(4),
                backgroundColor: Color(
                  0xff002F0F,
                ).withAlpha((0.6 * 255).toInt()),
              ),
              SizedBox(width: context.w(4)),
              Text(
                context.tr.profit,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: context.appTheme.normal,
                ),
              ),
              SizedBox(width: context.w(8)),
              CircleAvatar(
                radius: context.w(4),
                backgroundColor: Color(0xffD91F1F),
              ),
              SizedBox(width: context.w(4)),
              Text(
                context.tr.loss,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: context.appTheme.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
