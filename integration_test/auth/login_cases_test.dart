import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tanami_capital/config/keys.dart';
import 'package:tanami_capital/features/auth/presentation/pages/auth_options_page.dart';
import 'package:tanami_capital/features/auth/presentation/pages/login_page.dart';
import 'package:tanami_capital/features/home/presentation/pages/home_page.dart';
import 'package:tanami_capital/shared/providers/biometrics/biometrics_provider.dart';

import '../test_helpers.dart';

void main() {
  group('Login Test Cases', () {
    patrolTest('Login Validations test', ($) async {
      await runTanamiApp($);
      await $.waitUntilVisible(find.byType(AuthOptionsPage));

      await $.tap(find.byKey(kLoginWithEmailButtonKey));
      // Empty email and password
      await $.tap(find.byKey(kLoginButtonKey));
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);

      // Invalid email and password
      await $.enterText(find.byKey(kLoginEmailFieldKey), 'invalidemail');
      await $.enterText(find.byKey(kLoginPasswordFieldKey), '123');
      await $.tap(find.byKey(kLoginButtonKey));
      expect(find.text('Invalid email format'), findsOneWidget);
      expect(find.text('Password min length is 6 characters'), findsOneWidget);
    });

    patrolTest('Invalid Credintials Login', ($) async {
      await runTanamiApp($);
      final testingEmail = dotenv.env["TESTING_EMAIL"];

      await $.waitUntilVisible(find.byType(AuthOptionsPage));

      await $.tap(find.byKey(kLoginWithEmailButtonKey));

      await $.waitUntilVisible(find.byType(LoginPage));

      await $.enterText(find.byKey(kLoginEmailFieldKey), 'test@test.com');

      await $.enterText(find.byKey(kLoginPasswordFieldKey), '123456');

      await $.tap(find.byKey(kLoginButtonKey));

      await $.waitUntilVisible(find.text('Email is not registered'));

      await $.enterText(find.byKey(kLoginEmailFieldKey), testingEmail ?? '');
      await $.tap(find.byKey(kLoginButtonKey));

      await $.waitUntilVisible(find.text('Invalid Password'));
    });
    patrolTest('Succesfull Login', ($) async {
      final ref = await runTanamiApp($);
      final testingEmail = dotenv.env["TESTING_EMAIL"];
      final testingPassword = dotenv.env["TESTING_PASSWORD"];
      final testingPin = dotenv.env["TESTING_PIN"];

      await ref.read(canLoginPasswordLessProvider.future);

      await $.waitUntilVisible(find.byType(AuthOptionsPage));

      await $.tap(find.byKey(kLoginWithEmailButtonKey));

      await $.waitUntilVisible(find.byType(LoginPage));

      await $.enterText(find.byKey(kLoginEmailFieldKey), testingEmail ?? '');

      await $.enterText(
        find.byKey(kLoginPasswordFieldKey),
        testingPassword ?? '',
      );

      await $.tap(find.byKey(kLoginButtonKey));

      await $.waitUntilVisible(find.byKey(kPinSheetFieldKey));

      await enterPin($, testingPin ?? '', ref);
      await $.waitUntilVisible(find.byType(HomePage));
    });

    patrolTest('Pin Password Login', ($) async {
      final ref = await runTanamiAppWithSavedLogin($);
      final testingPin = dotenv.env["TESTING_PIN"];

      await $.waitUntilVisible(find.byType(AuthOptionsPage));

      await $.tap(find.byKey(kLoginWithPinButtonKey));

      await $.waitUntilVisible(find.byKey(kPinSheetFieldKey));

      await enterPin($, testingPin ?? '', ref);
      await $.waitUntilVisible(find.byType(HomePage));
    });
  });
}
