import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'Localization_service/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'HelpDesk Lite'**
  String get appName;

  /// No description provided for @myTickets.
  ///
  /// In en, this message translates to:
  /// **'My Tickets'**
  String get myTickets;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log in to manage your support tickets.'**
  String get loginSubtitle;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @signupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign up to submit and track support requests.'**
  String get signupSubtitle;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @emailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'name@company.com'**
  String get emailPlaceholder;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get passwordPlaceholder;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot?'**
  String get forgotPassword;

  /// No description provided for @havingTrouble.
  ///
  /// In en, this message translates to:
  /// **'Having trouble?'**
  String get havingTrouble;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @splashTitle.
  ///
  /// In en, this message translates to:
  /// **'HelpDesk'**
  String get splashTitle;

  /// No description provided for @splashTitleAccent.
  ///
  /// In en, this message translates to:
  /// **'Lite'**
  String get splashTitleAccent;

  /// No description provided for @splashSubtitle.
  ///
  /// In en, this message translates to:
  /// **'IT support, simplified.'**
  String get splashSubtitle;

  /// No description provided for @splashStartingUp.
  ///
  /// In en, this message translates to:
  /// **'Starting up'**
  String get splashStartingUp;

  /// No description provided for @splashConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting'**
  String get splashConnecting;

  /// No description provided for @splashReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get splashReady;

  /// No description provided for @yourTickets.
  ///
  /// In en, this message translates to:
  /// **'Your Tickets'**
  String get yourTickets;

  /// No description provided for @yourTicketsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage and track your active support requests.'**
  String get yourTicketsSubtitle;

  /// No description provided for @manageAssignedIssues.
  ///
  /// In en, this message translates to:
  /// **'Manage and respond to your assigned issues.'**
  String get manageAssignedIssues;

  /// No description provided for @searchTicketsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search tickets, IDs, or keywords...'**
  String get searchTicketsPlaceholder;

  /// No description provided for @searchTicketsDesktopPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search tickets, IDs, or users...'**
  String get searchTicketsDesktopPlaceholder;

  /// No description provided for @filterAllActive.
  ///
  /// In en, this message translates to:
  /// **'All Active'**
  String get filterAllActive;

  /// No description provided for @filterOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get filterOpen;

  /// No description provided for @filterPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get filterPending;

  /// No description provided for @filterWaiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get filterWaiting;

  /// No description provided for @filterDelayed.
  ///
  /// In en, this message translates to:
  /// **'Delayed'**
  String get filterDelayed;

  /// No description provided for @filterDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get filterDate;

  /// No description provided for @statusOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get statusOpen;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusDelayed.
  ///
  /// In en, this message translates to:
  /// **'Delayed'**
  String get statusDelayed;

  /// No description provided for @statusWaiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get statusWaiting;

  /// No description provided for @statusResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get statusResolved;

  /// No description provided for @statusClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get statusClosed;

  /// No description provided for @priorityUrgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get priorityUrgent;

  /// No description provided for @priorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get priorityHigh;

  /// No description provided for @priorityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get priorityMedium;

  /// No description provided for @priorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get priorityLow;

  /// No description provided for @endOfActiveTickets.
  ///
  /// In en, this message translates to:
  /// **'End of active tickets'**
  String get endOfActiveTickets;

  /// No description provided for @navMyTickets.
  ///
  /// In en, this message translates to:
  /// **'My Tickets'**
  String get navMyTickets;

  /// No description provided for @navNewTicket.
  ///
  /// In en, this message translates to:
  /// **'New Ticket'**
  String get navNewTicket;

  /// No description provided for @navQueue.
  ///
  /// In en, this message translates to:
  /// **'Queue'**
  String get navQueue;

  /// No description provided for @navOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get navOverview;

  /// No description provided for @navSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get navSupport;

  /// No description provided for @navArchive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get navArchive;

  /// No description provided for @tableHeaderId.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get tableHeaderId;

  /// No description provided for @tableHeaderSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get tableHeaderSubject;

  /// No description provided for @tableHeaderStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get tableHeaderStatus;

  /// No description provided for @tableHeaderPriority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get tableHeaderPriority;

  /// No description provided for @tableHeaderUpdated.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get tableHeaderUpdated;

  /// No description provided for @internalOps.
  ///
  /// In en, this message translates to:
  /// **'Internal Ops'**
  String get internalOps;

  /// No description provided for @createTicketTitle.
  ///
  /// In en, this message translates to:
  /// **'Submit a Request'**
  String get createTicketTitle;

  /// No description provided for @createTicketSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Provide as much detail as possible so we can best assist you.'**
  String get createTicketSubtitle;

  /// No description provided for @ticketSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get ticketSubject;

  /// No description provided for @ticketSubjectPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Brief summary of your issue'**
  String get ticketSubjectPlaceholder;

  /// No description provided for @ticketCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get ticketCategory;

  /// No description provided for @ticketSelectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select a category'**
  String get ticketSelectCategory;

  /// No description provided for @categoryTechnical.
  ///
  /// In en, this message translates to:
  /// **'Technical Support'**
  String get categoryTechnical;

  /// No description provided for @categoryBilling.
  ///
  /// In en, this message translates to:
  /// **'Billing & Subscriptions'**
  String get categoryBilling;

  /// No description provided for @categoryAccount.
  ///
  /// In en, this message translates to:
  /// **'Account Management'**
  String get categoryAccount;

  /// No description provided for @categoryGeneral.
  ///
  /// In en, this message translates to:
  /// **'General Inquiry'**
  String get categoryGeneral;

  /// No description provided for @ticketPriority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get ticketPriority;

  /// No description provided for @ticketDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get ticketDescription;

  /// No description provided for @ticketDescriptionPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Please describe your issue in detail...'**
  String get ticketDescriptionPlaceholder;

  /// No description provided for @ticketAttachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get ticketAttachments;

  /// No description provided for @ticketUploadZoneHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to upload images or drop files here\n(Max 5MB per file, 25MB total)'**
  String get ticketUploadZoneHint;

  /// No description provided for @submitTicket.
  ///
  /// In en, this message translates to:
  /// **'Submit Ticket'**
  String get submitTicket;

  /// No description provided for @subjectRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a subject'**
  String get subjectRequired;

  /// No description provided for @categoryRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a category'**
  String get categoryRequired;

  /// No description provided for @descriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a description'**
  String get descriptionRequired;

  /// No description provided for @descriptionTooShort.
  ///
  /// In en, this message translates to:
  /// **'Description must be at least 10 characters'**
  String get descriptionTooShort;

  /// No description provided for @fileSizeExceededError.
  ///
  /// In en, this message translates to:
  /// **'A selected file exceeds the 5MB limit'**
  String get fileSizeExceededError;

  /// No description provided for @totalSizeExceededError.
  ///
  /// In en, this message translates to:
  /// **'Total attachments size exceeds the 25MB limit'**
  String get totalSizeExceededError;

  /// No description provided for @ticketSubmittedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Ticket submitted successfully'**
  String get ticketSubmittedSuccess;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logged in successfully'**
  String get loginSuccess;

  /// No description provided for @authErrorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get authErrorInvalidCredentials;

  /// No description provided for @authErrorEmailNotConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Email is not confirmed yet. Please check your inbox.'**
  String get authErrorEmailNotConfirmed;

  /// No description provided for @authErrorRateLimit.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please wait a moment and try again.'**
  String get authErrorRateLimit;

  /// No description provided for @authErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. Please try again.'**
  String get authErrorGeneric;

  /// No description provided for @buttonErrorFixFields.
  ///
  /// In en, this message translates to:
  /// **'Please fix form errors'**
  String get buttonErrorFixFields;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
