import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/shared/entities/investment_entity.dart';
import 'package:tanami_capital/shared/widgets/pdf_sheet.dart';

class InvestmentCard extends StatelessWidget {
  final InvestmentEntity investment;
  const InvestmentCard({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w(8),
        vertical: context.h(6),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(context.w(50)),
          bottomEnd: Radius.circular(context.w(12)),
          bottomStart: Radius.circular(context.w(12)),
          topEnd: Radius.circular(context.w(12)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(context.w(40)),
              bottomEnd: Radius.circular(context.w(20)),
            ),
            child: Image.network(
              investment.image,
              width: double.infinity,
              height: context.h(138),

              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: context.h(12)),
          Text(
            investment.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Text(
                context.tr.expectedReturn,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              Expanded(child: Text(investment.expectedReturn)),
            ],
          ),

          Row(
            children: [
              Text(
                context.tr.duration,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              Expanded(child: Text(investment.duration)),
            ],
          ),
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () async {
                  log(investment.pdfLink);
                  PdfSheet.open(
                    context,
                    investment.pdfLink,
                    title: investment.name,
                  );
                },
                child: Text(
                  context.tr.viewDetails,
                  style: TextStyle(
                    color: context.appTheme.normal,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
