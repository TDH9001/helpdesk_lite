// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'HelpDesk Lite';

  @override
  String get myTickets => 'تذاكري';

  @override
  String get logIn => 'تسجيل الدخول';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get welcomeBack => 'مرحباً بعودتك';

  @override
  String get loginSubtitle => 'سجل الدخول لإدارة تذاكر الدعم الخاصة بك.';

  @override
  String get createAccount => 'إنشاء حساب جديد';

  @override
  String get signupSubtitle => 'أنشئ حساباً لتقديم ومتابعة طلبات الدعم.';

  @override
  String get emailAddress => 'البريد الإلكتروني';

  @override
  String get emailPlaceholder => 'name@company.com';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordPlaceholder => '••••••••';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get havingTrouble => 'هل تواجه مشكلة؟';

  @override
  String get contactSupport => 'تواصل مع الدعم';

  @override
  String get emailRequired => 'يرجى إدخال البريد الإلكتروني';

  @override
  String get emailInvalid => 'يرجى إدخال بريد إلكتروني صالح';

  @override
  String get passwordRequired => 'يرجى إدخال كلمة المرور';

  @override
  String get passwordTooShort => 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';

  @override
  String get confirmPasswordRequired => 'يرجى تأكيد كلمة المرور';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';
}
