import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanami_capital/config/keys.dart';
import 'package:tanami_capital/config/router/routes.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/password_less_login/login_options.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/or_divider.dart';
import 'package:tanami_capital/gen/assets/assets.gen.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';
import 'package:tanami_capital/shared/widgets/change_lang/change_lang_button.dart';

class AuthOptionsPage extends ConsumerWidget {
  final String? from;
  const AuthOptionsPage({super.key, this.from});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Assets.jpg.auth.image(
            width: double.infinity,
            height: context.h(580),
            fit: BoxFit.fill,
          ),
          Container(
            margin: EdgeInsets.only(top: context.h(120)),
            alignment: Alignment.topCenter,
            child: Assets.svg.logo.svg(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(context.w(24)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(context.w(24)),
                  topRight: Radius.circular(context.w(24)),
                ),
              ),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr.authWelcome,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: context.appTheme.normal,
                    ),
                  ),
                  SizedBox(height: context.h(16)),
                  LoginOptions(),

                  OrDivider(),
                  AppButton(
                    key: kCreateAccountButtonKey,
                    hoverColor: context.appTheme.lightHover,
                    color: context.appTheme.normal,
                    child: Text(
                      context.tr.createAccount,
                      style: TextStyle(color: context.appTheme.white),
                    ),
                    onPressed: () => SignupRoute().push(context),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.w(20),
              vertical: context.h(40),
            ),
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: ChangeLangButton(),
            ),
          ),
        ],
      ),
    );
  }
}
