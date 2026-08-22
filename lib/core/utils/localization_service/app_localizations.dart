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

  /// No description provided for @usernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameLabel;

  /// No description provided for @usernamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. johndoe'**
  String get usernamePlaceholder;

  /// No description provided for @usernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your username'**
  String get usernameRequired;

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
  /// **'Queue Items'**
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

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage appearance, language, and session.'**
  String get settingsSubtitle;

  /// No description provided for @appearanceSection.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceSection;

  /// No description provided for @languageSection.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSection;

  /// No description provided for @accountSection.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountSection;

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

  /// No description provided for @uploadingAttachments.
  ///
  /// In en, this message translates to:
  /// **'Uploading attachments... {percentage}%'**
  String uploadingAttachments(int percentage);

  /// No description provided for @submittingTicket.
  ///
  /// In en, this message translates to:
  /// **'Submitting ticket...'**
  String get submittingTicket;

  /// No description provided for @ticketSubmittingError.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit ticket. Please try again.'**
  String get ticketSubmittingError;

  /// No description provided for @chatTitle.
  ///
  /// In en, this message translates to:
  /// **'Support Chat'**
  String get chatTitle;

  /// No description provided for @chatTypeMessagePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Type your message...'**
  String get chatTypeMessagePlaceholder;

  /// No description provided for @chatSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get chatSend;

  /// No description provided for @chatViewAttachments.
  ///
  /// In en, this message translates to:
  /// **'View Attachments'**
  String get chatViewAttachments;

  /// No description provided for @chatNoAttachments.
  ///
  /// In en, this message translates to:
  /// **'No attachments for this ticket'**
  String get chatNoAttachments;

  /// No description provided for @chatAttachmentsDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Ticket Attachments'**
  String get chatAttachmentsDialogTitle;

  /// No description provided for @chatAttachmentCount.
  ///
  /// In en, this message translates to:
  /// **'{count} files selected'**
  String chatAttachmentCount(int count);

  /// No description provided for @chatEmptyNoMessages.
  ///
  /// In en, this message translates to:
  /// **'No messages yet. Send a message to start the conversation.'**
  String get chatEmptyNoMessages;

  /// No description provided for @chatSendingMessage.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get chatSendingMessage;

  /// No description provided for @chatWorkerTag.
  ///
  /// In en, this message translates to:
  /// **'Support Agent'**
  String get chatWorkerTag;

  /// No description provided for @chatYouTag.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get chatYouTag;

  /// No description provided for @chatTicketInfo.
  ///
  /// In en, this message translates to:
  /// **'Ticket Information'**
  String get chatTicketInfo;

  /// No description provided for @chatTicketDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get chatTicketDetails;

  /// No description provided for @chatUploadAttachments.
  ///
  /// In en, this message translates to:
  /// **'Add Files / Images'**
  String get chatUploadAttachments;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logged in successfully'**
  String get loginSuccess;

  /// No description provided for @signupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get signupSuccess;

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

  /// No description provided for @authErrorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your internet connection.'**
  String get authErrorNetwork;

  /// No description provided for @authErrorUserAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists.'**
  String get authErrorUserAlreadyExists;

  /// No description provided for @authErrorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak. Please use at least 6 characters.'**
  String get authErrorWeakPassword;

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

  /// No description provided for @overviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overviewTitle;

  /// No description provided for @overviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Monitor team productivity and system load.'**
  String get overviewSubtitle;

  /// No description provided for @addNewAgent.
  ///
  /// In en, this message translates to:
  /// **'Add New Agent'**
  String get addNewAgent;

  /// No description provided for @totalOpenTickets.
  ///
  /// In en, this message translates to:
  /// **'Total Open Tickets'**
  String get totalOpenTickets;

  /// No description provided for @totalOpenTicketsBadge.
  ///
  /// In en, this message translates to:
  /// **'+12%'**
  String get totalOpenTicketsBadge;

  /// No description provided for @createdThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Created This Week'**
  String get createdThisWeek;

  /// No description provided for @createdThisWeekCount.
  ///
  /// In en, this message translates to:
  /// **'384'**
  String get createdThisWeekCount;

  /// No description provided for @vsLastWeek.
  ///
  /// In en, this message translates to:
  /// **'vs 412 last week'**
  String get vsLastWeek;

  /// No description provided for @ticketsPerAgent.
  ///
  /// In en, this message translates to:
  /// **'Tickets per Agent'**
  String get ticketsPerAgent;

  /// No description provided for @agentTicketsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} tickets'**
  String agentTicketsCount(int count);

  /// No description provided for @noAgentsFound.
  ///
  /// In en, this message translates to:
  /// **'No agents found'**
  String get noAgentsFound;

  /// No description provided for @addNewAgentTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Agent Account'**
  String get addNewAgentTitle;

  /// No description provided for @addNewAgentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Provision a new support agent.'**
  String get addNewAgentSubtitle;

  /// No description provided for @agentNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name or Nickname'**
  String get agentNameLabel;

  /// No description provided for @agentNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Jane Doe'**
  String get agentNameHint;

  /// No description provided for @agentRoleLabel.
  ///
  /// In en, this message translates to:
  /// **'Role Level'**
  String get agentRoleLabel;

  /// No description provided for @roleWorker.
  ///
  /// In en, this message translates to:
  /// **'Support Worker'**
  String get roleWorker;

  /// No description provided for @roleManager.
  ///
  /// In en, this message translates to:
  /// **'Shift Manager'**
  String get roleManager;

  /// No description provided for @createAgentButton.
  ///
  /// In en, this message translates to:
  /// **'Create Agent'**
  String get createAgentButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @agentCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Agent created successfully'**
  String get agentCreatedSuccess;

  /// No description provided for @workerCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Worker created successfully'**
  String get workerCreatedSuccess;

  /// No description provided for @managerCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Manager created successfully'**
  String get managerCreatedSuccess;

  /// No description provided for @ticketQueueTitle.
  ///
  /// In en, this message translates to:
  /// **'Ticket Queue'**
  String get ticketQueueTitle;

  /// No description provided for @ticketQueueSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage incoming and unassigned support tickets.'**
  String get ticketQueueSubtitle;

  /// No description provided for @searchQueuePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search tickets, customers, or IDs...'**
  String get searchQueuePlaceholder;

  /// No description provided for @filterUnassigned.
  ///
  /// In en, this message translates to:
  /// **'Unassigned'**
  String get filterUnassigned;

  /// No description provided for @filterHighPriority.
  ///
  /// In en, this message translates to:
  /// **'High Priority'**
  String get filterHighPriority;

  /// No description provided for @assignToMe.
  ///
  /// In en, this message translates to:
  /// **'Assign to me'**
  String get assignToMe;

  /// No description provided for @assignedToYouSuccess.
  ///
  /// In en, this message translates to:
  /// **'Ticket assigned to you successfully'**
  String get assignedToYouSuccess;

  /// No description provided for @noTicketsFound.
  ///
  /// In en, this message translates to:
  /// **'No tickets found'**
  String get noTicketsFound;

  /// No description provided for @noQueueTicketsFound.
  ///
  /// In en, this message translates to:
  /// **'No tickets match the selected filters'**
  String get noQueueTicketsFound;

  /// No description provided for @statusNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get statusNew;

  /// No description provided for @statusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get statusInProgress;

  /// No description provided for @tableHeaderCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get tableHeaderCustomer;

  /// No description provided for @tableHeaderAssignee.
  ///
  /// In en, this message translates to:
  /// **'Assignee'**
  String get tableHeaderAssignee;

  /// No description provided for @tableHeaderActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get tableHeaderActions;

  /// No description provided for @unassignedLabel.
  ///
  /// In en, this message translates to:
  /// **'Unassigned'**
  String get unassignedLabel;

  /// No description provided for @workerChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Ticket Details'**
  String get workerChatTitle;

  /// No description provided for @publicReplyTab.
  ///
  /// In en, this message translates to:
  /// **'Public Reply'**
  String get publicReplyTab;

  /// No description provided for @internalNoteTab.
  ///
  /// In en, this message translates to:
  /// **'Internal Note'**
  String get internalNoteTab;

  /// No description provided for @internalNoteBadge.
  ///
  /// In en, this message translates to:
  /// **'Internal'**
  String get internalNoteBadge;

  /// No description provided for @internalNotePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Add an internal note (only visible to agents)...'**
  String get internalNotePlaceholder;

  /// No description provided for @publicReplyPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Type your message here...'**
  String get publicReplyPlaceholder;

  /// No description provided for @addNoteButton.
  ///
  /// In en, this message translates to:
  /// **'Add Note'**
  String get addNoteButton;

  /// No description provided for @changeStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Status'**
  String get changeStatusTitle;

  /// No description provided for @changePriorityTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Priority'**
  String get changePriorityTitle;

  /// No description provided for @changeCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Category'**
  String get changeCategoryTitle;

  /// No description provided for @assigneeLabel.
  ///
  /// In en, this message translates to:
  /// **'Assignee'**
  String get assigneeLabel;

  /// No description provided for @reassignLabel.
  ///
  /// In en, this message translates to:
  /// **'Reassign'**
  String get reassignLabel;

  /// No description provided for @customerInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer Details'**
  String get customerInfoTitle;

  /// No description provided for @customerTag.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customerTag;

  /// No description provided for @attachImageTooltip.
  ///
  /// In en, this message translates to:
  /// **'Attach Image'**
  String get attachImageTooltip;

  /// No description provided for @attachFileTooltip.
  ///
  /// In en, this message translates to:
  /// **'Attach File'**
  String get attachFileTooltip;

  /// No description provided for @statusUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Status updated successfully'**
  String get statusUpdatedSuccess;

  /// No description provided for @priorityUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Priority updated successfully'**
  String get priorityUpdatedSuccess;

  /// No description provided for @categoryUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Category updated successfully'**
  String get categoryUpdatedSuccess;

  /// No description provided for @internalNoteHelperText.
  ///
  /// In en, this message translates to:
  /// **'Internal notes are only visible to support workers and administrators.'**
  String get internalNoteHelperText;
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
