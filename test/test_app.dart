import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tanami_capital/core/responsive/responsive_builder.dart';
import 'package:tanami_capital/core/theme/light.dart';
import 'package:tanami_capital/gen/l10n/app_localizations.dart';

class TestApp extends StatelessWidget {
  final Widget home;
  final Locale locale;
  final ThemeMode themeMode;
  final GlobalKey<NavigatorState>? navigatorKey;
  final List<LocalizationsDelegate<dynamic>> delegates;
  final List<Override> overrides;

  static Future<BuildContext> buildContext(
    WidgetTester tester, {
    Locale locale = const Locale('en'),
    List<LocalizationsDelegate<dynamic>> delegates =
        AppLocalizations.localizationsDelegates,
    List<Override> overrides = const <Override>[],
  }) async {
    late BuildContext context;
    await tester.pumpWidget(
      TestApp(
        overrides: overrides,
        locale: locale,
        delegates: delegates,
        home: Scaffold(
          body: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox();
            },
          ),
        ),
      ),
    );
    return context;
  }

  static Future<WidgetRef> buildWidgetRef(
    WidgetTester tester, {
    Widget? child,
    Locale locale = const Locale('en'),
    List<LocalizationsDelegate<dynamic>> delegates =
        AppLocalizations.localizationsDelegates,
    List<Override> overrides = const <Override>[],
  }) async {
    late WidgetRef generatedRef;
    await tester.pumpWidget(
      TestApp(
        overrides: overrides,
        locale: locale,
        delegates: delegates,
        home: Scaffold(
          body: Consumer(
            builder: (ctx, ref, child) {
              generatedRef = ref;
              return child ?? const SizedBox();
            },
          ),
        ),
      ),
    );
    return generatedRef;
  }

  static Future<BuildContext> buildContextForMediaQuery(
    WidgetTester tester,
    Size size,
  ) async {
    late BuildContext context;
    await tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(size: size),
        child: Builder(
          builder: (ctx) {
            context = ctx;
            return const SizedBox();
          },
        ),
      ),
    );
    return context;
  }

  const TestApp({
    required this.home,
    super.key,
    this.locale = const Locale('en'),
    this.navigatorKey,
    this.delegates = AppLocalizations.localizationsDelegates,
    this.themeMode = ThemeMode.system,
    this.overrides = const <Override>[],
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: overrides,
      child: ResponsiveBuilder(
        figmaDesignSize: Size(375, 812),
        child: MaterialApp(
          navigatorKey: navigatorKey,
          localizationsDelegates: delegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: locale,
          home: home,

          /// * theme
          themeMode: themeMode,
          theme: LightThemeExtension(locale: locale).theme,
          darkTheme: LightThemeExtension(locale: locale).theme,
        ),
      ),
    );
  }
}
