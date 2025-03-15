import 'package:flutter_test/flutter_test.dart';
import 'package:tanami_capital/features/auth/presentation/pages/confirm_otp_page.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/resend_otp_timer/resend_otp_timer.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';
import 'package:pinput/pinput.dart';

import '../../../../test_app.dart';

void main() {
  testWidgets("renders ConfirmOtpPage correctly", (tester) async {
    const testEmail = "test@example.com";

    await tester.pumpWidget(TestApp(home: ConfirmOtpPage(email: testEmail)));

    // Check if the OTP instruction text is displayed
    expect(find.text("Check Your Email"), findsOneWidget);
    expect(
      find.text(
        "We sent a password reset OTP to your email, please check your inbox",
      ),
      findsOneWidget,
    );

    // Check if the OTP input field (Pinput) is displayed
    expect(find.byType(Pinput), findsOneWidget);

    // Check if the "Verify" button is displayed
    expect(find.text("Verify"), findsOneWidget);
    expect(find.byType(AppButton), findsNWidgets(2));

    // Check if the Resend OTP timer is displayed
    expect(find.byType(ResendOtpTimer), findsOneWidget);
  });
}
