// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get authWelcome => 'مرحبًا! كيف تود تسجيل الدخول؟';

  @override
  String get loginWithPin => 'الدخول باستخدام الرمز';

  @override
  String get loginWithBiometrics => 'الدخول باستخدام البصمة';

  @override
  String get loginWithGoogle => 'تسجيل الدخول باستخدام جوجل';

  @override
  String get loginWithEmail => 'الدخول باستخدام البريد الإلكتروني';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get signup => 'إنشاء حساب';

  @override
  String get or => 'أو';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get getStartedHeader => 'إنشاء حساب أو تسجيل الدخول لاستكشاف تطبيقنا';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String enterYour(Object label) {
    return 'أدخل $label';
  }

  @override
  String enter(Object label) {
    return 'أدخل $label';
  }

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get forgetPassword => 'نسيت كلمة المرور ؟';

  @override
  String get invalidEmailFormat => 'تنسيق البريد الإلكتروني غير صالح';

  @override
  String required(Object label) {
    return '$label مطلوب';
  }

  @override
  String get passwordMinLength => 'الحد الأدنى لطول كلمة المرور هو 6 أحرف';

  @override
  String get passwordMustHave => 'يجب أن تحتوي كلمة المرور على:';

  @override
  String get ulcletters => 'أحرف كبيرة وصغيرة';

  @override
  String get specialCharacters => 'أحرف خاصة (#\$&)';

  @override
  String get numbers => 'أرقام';

  @override
  String get minLength => 'الحد الأدنى للطول 6 أحرف';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get passwordsDoNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get forgetPassTitle => 'نسيت كلمة المرور';

  @override
  String get forgetPassText => 'لا تقلق، أدخل عنوان بريدك الإلكتروني أدناه، وسنرسل لك رمز التحقق إلى بريدك الإلكتروني';

  @override
  String get sendOtp => 'إرسال رمز التحقق';

  @override
  String get checkEmail => 'تحقق من بريدك الإلكتروني';

  @override
  String get weSentOtp => 'لقد أرسلنا رمز التحقق لإعادة تعيين كلمة المرور إلى بريدك الإلكتروني، يرجى التحقق من صندوق الوارد';

  @override
  String get pleaseEnterOtp => 'من فضلك! أدخل رمز التحقق';

  @override
  String get otpMinLength => 'يجب أن يكون طول رمز التحقق 6';

  @override
  String get verify => 'تحقق';

  @override
  String get didntReceiveCode => 'لم تتلق الرمز؟';

  @override
  String get resendOtp => 'إعادة إرسال رمز التحقق';

  @override
  String get createNewPassword => 'إنشاء كلمة مرور جديدة';

  @override
  String get enterNewPass => 'أدخل كلمة المرور الجديدة أدناه لإكمال عملية إعادة التعيين.';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get confirmNewPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get error => 'خطأ';

  @override
  String get ok => 'حسنًا';

  @override
  String get close => 'إغلاق';

  @override
  String get home => 'الرئيسية';

  @override
  String get search => 'بحث';

  @override
  String get investments => 'الاستثمارات';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String welcome(Object name) {
    return 'مرحبًا، $name';
  }

  @override
  String get investmentSummary => 'ملخص الاستثمار';

  @override
  String get totalPortfolio => 'إجمالي قيمة المحفظة';

  @override
  String get thisMonth => 'هذا الشهر 4.5';

  @override
  String get profit => 'الربح';

  @override
  String get loss => 'الخسارة';

  @override
  String get depositeFunds => 'إيداع الأموال';

  @override
  String get withdrawFunds => 'سحب الأموال';

  @override
  String get newInvestment => 'استثمار جديد';

  @override
  String get viewInvestments => 'عرض الاستثمارات';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get investmentOpportunities => 'فرص الاستثمار';

  @override
  String get quickActions => 'إجراءات سريعة';

  @override
  String get viewDetails => 'عرض التفاصيل';

  @override
  String get expectedReturn => 'العائد المتوقع: ';

  @override
  String get duration => 'المدة: ';

  @override
  String get invalidPin => 'الرمز غير صالح';

  @override
  String get please => 'من فضلك';

  @override
  String get setPinToContinue => 'يجب عليك تعيين رمز للمتابعة';

  @override
  String get setPin => 'تعيين الرمز';

  @override
  String get cancel => 'إلغاء';

  @override
  String get setPinForSecure => 'تعيين رمز لتسجيل الدخول الآمن والسهل';

  @override
  String get searchHint => 'ابحث...';

  @override
  String get errorOccured => 'حدث خطأ غير متوقع';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get changeLang => 'تغيير اللغة';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get submit => 'إرسال';
}
