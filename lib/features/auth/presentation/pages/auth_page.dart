import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tanami_capital/config/router/routes.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/main_auth_layout.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';

class AuthPage extends StatelessWidget {
  final Widget child;
  const AuthPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    bool isSelected(String path) {
      final String location = GoRouterState.of(context).uri.path;
      return location.contains(path);
    }

    Widget authNavOption({required String text, required String path}) {
      return AppButton(
        onPressed: () {
          final String location = GoRouterState.of(context).uri.path;
          if (location.contains(path)) return;
          GoRouter.of(context).pushReplacement(path);
        },
        color:
            isSelected(path) ? context.appTheme.white : context.appTheme.light,
        borderColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: Text(text, style: TextStyle(color: context.appTheme.normal)),
      );
    }

    return MainAuthLayout(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.w(20),
          vertical: context.h(20),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(context.w(2)),
              decoration: BoxDecoration(
                color: context.appTheme.light,
                borderRadius: BorderRadius.circular(context.w(12)),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: authNavOption(
                      text: context.tr.login,
                      path: LoginRoute().location,
                    ),
                  ),
                  SizedBox(width: context.w(10)),
                  Expanded(
                    child: authNavOption(
                      text: context.tr.signup,
                      path: SignupRoute().location,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
