import 'package:flutter/material.dart';
import 'package:tanami_capital/gen/l10n/app_localizations.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this);
}
