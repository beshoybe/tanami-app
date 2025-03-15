// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get authWelcome => 'Welcome! How would you like to sign in?';

  @override
  String get loginWithPin => 'Login with Pin';

  @override
  String get loginWithBiometrics => 'Login with Biometrics';

  @override
  String get loginWithGoogle => 'Login with Google';

  @override
  String get loginWithEmail => 'Login with Email';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signup => 'Signup';

  @override
  String get or => 'Or';

  @override
  String get createAccount => 'Create an account';

  @override
  String get getStarted => 'Get Started now';

  @override
  String get getStartedHeader => 'Create an account or log in to explore about our app';

  @override
  String get login => 'Login';

  @override
  String enterYour(Object label) {
    return 'Enter your $label';
  }

  @override
  String enter(Object label) {
    return 'Enter $label';
  }

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get forgetPassword => 'Forget Password ?';

  @override
  String get invalidEmailFormat => 'Invalid email format';

  @override
  String required(Object label) {
    return '$label is required';
  }

  @override
  String get passwordMinLength => 'Password min length is 6 characters';

  @override
  String get passwordMustHave => 'Password must have :';

  @override
  String get ulcletters => 'Upper & Lower case letters';

  @override
  String get specialCharacters => 'Special characters (#\$&)';

  @override
  String get numbers => 'Numbers';

  @override
  String get minLength => '6 characteres min length';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get passwordsDoNotMatch => 'Passwords not match';

  @override
  String get forgetPassTitle => 'Forget password';

  @override
  String get forgetPassText => 'Don’t Worry, Enter your email address below, and we will send you an OTP to your email';

  @override
  String get sendOtp => 'Send OTP';

  @override
  String get checkEmail => 'Check Your Email';

  @override
  String get weSentOtp => 'We sent a password reset OTP to your email, please check your inbox';

  @override
  String get pleaseEnterOtp => 'Please! Enter OTP';

  @override
  String get otpMinLength => 'OTP length must be 6';

  @override
  String get verify => 'Verify';

  @override
  String get didntReceiveCode => 'Didn\'t receive code?';

  @override
  String get resendOtp => 'Resend OTP';

  @override
  String get createNewPassword => 'Create a new password';

  @override
  String get enterNewPass => 'Enter your new password below to complete the reset process .';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get error => 'Error';

  @override
  String get ok => 'Ok';

  @override
  String get close => 'Close';

  @override
  String get home => 'Home';

  @override
  String get search => 'Search';

  @override
  String get investments => 'Investments';

  @override
  String get profile => 'Profile';

  @override
  String welcome(Object name) {
    return 'Welcome, $name';
  }

  @override
  String get investmentSummary => 'Investment Summary';

  @override
  String get totalPortfolio => 'Total Portfolio Value';

  @override
  String get thisMonth => '+ 4.5  this month';

  @override
  String get profit => 'Profit';

  @override
  String get loss => 'Loss';

  @override
  String get depositeFunds => 'Deposite Funds';

  @override
  String get withdrawFunds => 'Withdraw Funds';

  @override
  String get newInvestment => 'New Investment';

  @override
  String get viewInvestments => 'View Investments';

  @override
  String get viewAll => 'View All';

  @override
  String get investmentOpportunities => 'Investment Opportunities';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get viewDetails => 'View Details';

  @override
  String get expectedReturn => 'Expected Return: ';

  @override
  String get duration => 'Duration: ';

  @override
  String get invalidPin => 'Invalid Pin';

  @override
  String get please => 'Please';

  @override
  String get setPinToContinue => 'You must set a pin to continue';

  @override
  String get setPin => 'Set Pin';

  @override
  String get cancel => 'Cancel';

  @override
  String get setPinForSecure => 'Set pin for secure and easy login';

  @override
  String get searchHint => 'Search...';

  @override
  String get errorOccured => 'Unexpected error occured';

  @override
  String get retry => 'Retry';

  @override
  String get settings => 'Settings';

  @override
  String get changeLang => 'Change Language';

  @override
  String get logout => 'Logout';

  @override
  String get submit => 'Submit';
}
