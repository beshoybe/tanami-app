import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanami_capital/core/api/api_provider.dart';
import 'package:tanami_capital/core/locale/locale_provider.dart';
import 'package:tanami_capital/features/home/presentation/provider/home_provider.dart';
import 'package:tanami_capital/gen/l10n/app_localizations.dart';

class ChangeLangSheet extends ConsumerWidget {
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => const ChangeLangSheet._(),
    );
  }

  const ChangeLangSheet._();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: AppLocalizations.supportedLocales
            .map((locale) {
              return ListTile(
                title: Text(locale.languageCode.toUpperCase()),
                onTap: () {
                  ref.read(localeProvider.notifier).setLocale(locale);
                  ref.invalidate(apiHelperProvider);
                  ref.invalidate(homeDataProvider);
                  Navigator.of(context).pop();
                },
              );
            })
            .toList(growable: false),
      ),
    );
  }
}
