import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/gen/assets/assets.gen.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.quickActions,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: context.h(12)), // Space between title and buttons
        Row(
          children: [
            Expanded(
              child: _buildQuickAction(
                context,
                context.tr.depositeFunds,
                Assets.svg.deposit.path,
                () {},
              ),
            ),
            SizedBox(width: context.w(4)), // Space between buttons
            Expanded(
              child: _buildQuickAction(
                context,
                context.tr.viewInvestments,
                Assets.svg.insights.path,
                () {},
              ),
            ),
          ],
        ),
        SizedBox(height: context.h(12)), // Space between buttons
        Row(
          children: [
            Expanded(
              child: _buildQuickAction(
                context,
                context.tr.withdrawFunds,
                Assets.svg.withdraw.path,
                () {},
              ),
            ),
            SizedBox(width: context.w(4)), // Space between buttons
            Expanded(
              child: _buildQuickAction(
                context,
                context.tr.newInvestment,
                Assets.svg.addNew.path,
                () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAction(
    BuildContext context,
    String title,
    String image,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Button background
        borderRadius: BorderRadius.circular(12), // Rounded edges
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()), // Soft shadow
            offset: Offset(0, 4), // X: 0, Y: 4
            blurRadius: 12, // Softness of the shadow
          ),
        ],
      ),
      child: AppButton(
        padding: EdgeInsets.symmetric(horizontal: context.w(8)),
        borderColor: Colors.transparent,
        color: Colors.white, // Ensuring the button remains white
        onPressed: onTap,
        child: Row(
          children: [
            SvgPicture.asset(
              image,
              width: context.w(20),
              height: context.w(20),
            ), // Icon size
            SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black87, // Slightly darker text
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
