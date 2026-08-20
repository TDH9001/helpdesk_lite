// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'HelpDesk Lite';

  @override
  String get myTickets => 'My Tickets';

  @override
  String get logIn => 'Log In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get loginSubtitle => 'Log in to manage your support tickets.';

  @override
  String get createAccount => 'Create Account';

  @override
  String get signupSubtitle => 'Sign up to submit and track support requests.';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get emailPlaceholder => 'name@company.com';

  @override
  String get password => 'Password';

  @override
  String get passwordPlaceholder => '••••••••';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get forgotPassword => 'Forgot?';

  @override
  String get havingTrouble => 'Having trouble?';

  @override
  String get contactSupport => 'Contact Support';
}
