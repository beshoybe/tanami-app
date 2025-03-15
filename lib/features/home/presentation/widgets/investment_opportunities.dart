import 'package:flutter/material.dart';
import 'package:tanami_capital/config/router/routes.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/shared/entities/investment_entity.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';
import 'package:tanami_capital/shared/widgets/investment_card.dart';

class InvestmentOpportunities extends StatelessWidget {
  final List<InvestmentEntity> investments;
  const InvestmentOpportunities({super.key, required this.investments});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.investmentOpportunities,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: investments.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: context.h(8)),
              child: InvestmentCard(investment: investments[index]),
            );
          },
        ),
        AppButton(
          color: context.appTheme.normal,
          child: Text(
            context.tr.viewAll,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => SearchRoute().go(context),
        ),
      ],
    );
  }
}
