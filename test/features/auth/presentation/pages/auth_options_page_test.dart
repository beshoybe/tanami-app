import 'package:flutter_test/flutter_test.dart';
import 'package:tanami_capital/features/auth/presentation/pages/auth_options_page.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/password_less_login/login_options.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/or_divider.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';
import 'package:tanami_capital/shared/widgets/change_lang/change_lang_button.dart';

import '../../../../test_app.dart';

void main() {
  testWidgets("renders AuthOptionsPage correctly", (tester) async {
    await tester.pumpWidget(TestApp(home: AuthOptionsPage()));

    // Check if login options are displayed
    expect(find.byType(LoginOptions), findsOneWidget);

    // Check if the "Create Account" button is displayed
    expect(find.text("Create an account"), findsOneWidget);

    // Check if the OR divider is displayed
    expect(find.byType(OrDivider), findsOneWidget);

    // Check if Change Language button exists
    expect(find.byType(ChangeLangButton), findsOneWidget);

    // Check if AppButton widget exists
    expect(find.byType(AppButton), findsNWidgets(3));
  });
}
