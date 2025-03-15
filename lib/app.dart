import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanami_capital/config/router/router.dart';
import 'package:tanami_capital/core/locale/locale_provider.dart';
import 'package:tanami_capital/core/responsive/responsive_builder.dart';
import 'package:tanami_capital/core/theme/light.dart';
import 'package:tanami_capital/core/theme/theme_builder.dart';
import 'package:tanami_capital/gen/l10n/app_localizations.dart';

class TanamiApp extends ConsumerWidget {
  const TanamiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    return DevicePreview(
      enabled: kDebugMode,
      builder: (context) {
        return ResponsiveBuilder(
          figmaDesignSize: const Size(375, 812),
          child: ThemeBuilder(
            builder: (theme) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                locale: locale,
                themeMode: theme,
                builder: DevicePreview.appBuilder,
                theme: LightThemeExtension(locale: locale).theme,
                routerConfig: ref.watch(goRouterProvider),
              );
            },
          ),
        );
      },
    );
  }
}
