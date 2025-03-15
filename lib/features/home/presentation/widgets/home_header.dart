import 'package:flutter/material.dart';
import 'package:tanami_capital/config/router/routes.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/gen/assets/assets.gen.dart';
import 'package:tanami_capital/shared/entities/user_entity.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';

class HomeHeader extends StatelessWidget {
  final UserEntity user;
  const HomeHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: context.h(32)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12), // Ensures rounded corners
            child: Assets.png.user.image(
              width: context.w(40),
              height: context.w(40),
            ),
          ),
          SizedBox(width: context.w(4)),
          Expanded(
            child: Text(
              context.tr.welcome(user.name),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(width: context.w(4)),
          AppButton(
            onPressed: () {},
            hoverColor: context.appTheme.lightHover,
            padding: EdgeInsets.symmetric(horizontal: context.w(2)),
            width: context.w(40),
            child: Assets.svg.notification.svg(
              width: context.w(20),
              height: context.w(20),
            ),
          ),
          SizedBox(width: context.w(8)),
          AppButton(
            onPressed: () => SettingsRoute().push(context),
            hoverColor: context.appTheme.lightHover,
            padding: EdgeInsets.symmetric(horizontal: context.w(2)),
            width: context.w(40),
            child: Assets.svg.settings.svg(
              width: context.w(20),
              height: context.w(20),
            ),
          ),
        ],
      ),
    );
  }
}
