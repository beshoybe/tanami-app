import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tanami_capital/gen/l10n/app_localizations.dart';
import 'package:tanami_capital/shared/widgets/change_lang/change_lang_button.dart';
import 'package:tanami_capital/shared/widgets/change_lang/change_lang_sheet.dart';

import '../../../test_app.dart';

void main() {
  testWidgets('ChangeLangSheet should render and allow locale selection', (
    tester,
  ) async {
    await tester.pumpWidget(
      TestApp(
        home: Scaffold(body: Builder(builder: (context) => ChangeLangButton())),
      ),
    );

    // Verify the button is present

    // Tap the button to open the modal sheet
    await tester.tap(find.byType(ChangeLangButton));
    await tester.pumpAndSettle();

    // Verify the bottom sheet is shown with language options
    for (var locale in AppLocalizations.supportedLocales) {
      expect(find.text(locale.languageCode.toUpperCase()), findsOneWidget);
    }

    // Tap on the first language option
    await tester.tap(
      find.text(
        AppLocalizations.supportedLocales.first.languageCode.toUpperCase(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify that the bottom sheet is closed after selection
    expect(find.byType(ChangeLangSheet), findsNothing);
  });
}
