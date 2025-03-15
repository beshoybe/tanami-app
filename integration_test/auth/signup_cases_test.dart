import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tanami_capital/config/keys.dart';
import 'package:tanami_capital/features/auth/presentation/pages/auth_options_page.dart';
import 'package:tanami_capital/features/auth/presentation/pages/signup_page.dart';
import 'package:tanami_capital/features/home/presentation/pages/home_page.dart';

import '../test_helpers.dart';

void main() {
  group('Signup Test Cases', () {
    patrolTest('Signup Validations Test', ($) async {
      await runTanamiApp($);
      await $.tap(find.byKey(kCreateAccountButtonKey));

      // Empty fields
      await $.tap(find.byKey(kSignupButtonKey));
      expect(find.text('First Name is required'), findsOneWidget);
      expect(find.text('Last Name is required'), findsOneWidget);
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsNWidgets(2));

      // Invalid email and password
      await $.enterText(find.byKey(kSignupFirstNameFieldKey), 'John');
      await $.enterText(find.byKey(kSignupLastNameFieldKey), 'Doe');
      await $.enterText(find.byKey(kSignupEmailFieldKey), 'invalidemail');
      await $.enterText(find.byKey(kSignupPasswordFieldKey), '123');
      await $.enterText(find.byKey(kSignupConfirmPasswordFieldKey), '321');
      await $.scrollUntilVisible(finder: find.byKey(kSignupButtonKey));
      await $.tap(find.byKey(kSignupButtonKey));

      expect(find.text('Invalid email format'), findsOneWidget);
      expect(find.text('Passwords not match'), findsOneWidget);
    });

    patrolTest('Successful Signup', ($) async {
      final ref = await runTanamiApp($);

      final testingFirstName = 'John';
      final testingLastName = 'Doe';
      final testingEmail = '${Random().nextInt(100000)}@example.com';
      final testingPassword = dotenv.env["TESTING_PASSWORD"];
      final testingPin = dotenv.env["TESTING_PIN"];

      await $.waitUntilVisible(find.byType(AuthOptionsPage));
      await $.tap(find.byKey(kCreateAccountButtonKey));

      await $.waitUntilVisible(find.byType(SignupPage));

      await $.enterText(find.byKey(kSignupFirstNameFieldKey), testingFirstName);
      await $.enterText(find.byKey(kSignupLastNameFieldKey), testingLastName);
      await $.enterText(find.byKey(kSignupEmailFieldKey), testingEmail);
      await $.enterText(
        find.byKey(kSignupPasswordFieldKey),
        testingPassword ?? 'Test@123',
      );
      await $.enterText(
        find.byKey(kSignupConfirmPasswordFieldKey),
        testingPassword ?? 'Test@123',
      );

      await $.tap(find.byKey(kSignupButtonKey));

      await $.waitUntilVisible(find.byKey(kPinSheetFieldKey));

      await enterPin($, testingPin ?? '', ref);
      await $.waitUntilVisible(find.byType(HomePage));
    });
  });
}
