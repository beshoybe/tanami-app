import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';

class AuthLoginOption extends StatelessWidget {
  final String text;
  final String icon;
  final void Function()? onTap;
  final bool enabled;
  final bool loading;
  const AuthLoginOption({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.enabled = true,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      loading: loading,
      enabled: enabled,
      loadingColor: context.appTheme.normal,

      margin: EdgeInsets.only(top: context.h(16)),
      padding: EdgeInsets.symmetric(horizontal: context.w(16)),
      onPressed: onTap,
      child: Row(
        children: [
          SvgPicture.asset(icon, width: context.w(19), height: context.w(19)),
          SizedBox(width: context.w(8)),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: context.appTheme.normal,
            ),
          ),
        ],
      ),
    );
  }
}
