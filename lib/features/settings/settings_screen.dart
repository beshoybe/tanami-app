import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanami_capital/config/router/routes.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/features/auth/presentation/providers/logout/logout_provider.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';
import 'package:tanami_capital/shared/widgets/change_lang/change_lang_sheet.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.w(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.h(16)),
              Text(
                context.tr.settings,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Divider(),
              SizedBox(height: context.h(16)),
              AppButton(
                color: context.appTheme.normal,
                onPressed: () => ChangeLangSheet.show(context),
                child: Row(
                  children: [
                    Icon(
                      Icons.language,
                      size: context.w(20),
                      color: context.appTheme.white,
                    ),
                    SizedBox(width: context.w(8)),
                    Text(
                      context.tr.changeLang,

                      style: TextStyle(color: context.appTheme.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.h(16)),
              AppButton(
                color: context.appTheme.normal,
                onPressed: () async {
                  await ref.read(logoutProvider.future);
                  if (!context.mounted) return;
                  AuthOptionsRoute().go(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: context.w(20),
                      color: context.appTheme.white,
                    ),
                    SizedBox(width: context.w(8)),
                    Text(
                      context.tr.logout,
                      style: TextStyle(color: context.appTheme.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
