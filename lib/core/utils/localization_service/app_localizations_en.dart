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

  @override
  String get emailRequired => 'Please enter your email';

  @override
  String get emailInvalid => 'Please enter a valid email address';

  @override
  String get passwordRequired => 'Please enter your password';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get confirmPasswordRequired => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get splashTitle => 'HelpDesk';

  @override
  String get splashTitleAccent => 'Lite';

  @override
  String get splashSubtitle => 'IT support, simplified.';

  @override
  String get splashStartingUp => 'Starting up';

  @override
  String get splashConnecting => 'Connecting';

  @override
  String get splashReady => 'Ready';

  @override
  String get yourTickets => 'Your Tickets';

  @override
  String get yourTicketsSubtitle =>
      'Manage and track your active support requests.';

  @override
  String get manageAssignedIssues =>
      'Manage and respond to your assigned issues.';

  @override
  String get searchTicketsPlaceholder => 'Search tickets, IDs, or keywords...';

  @override
  String get searchTicketsDesktopPlaceholder =>
      'Search tickets, IDs, or users...';

  @override
  String get filterAllActive => 'All Active';

  @override
  String get filterOpen => 'Open';

  @override
  String get filterPending => 'Pending';

  @override
  String get filterWaiting => 'Waiting';

  @override
  String get filterDelayed => 'Delayed';

  @override
  String get filterDate => 'Date';

  @override
  String get statusOpen => 'Open';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusDelayed => 'Delayed';

  @override
  String get statusWaiting => 'Waiting';

  @override
  String get statusResolved => 'Resolved';

  @override
  String get statusClosed => 'Closed';

  @override
  String get priorityUrgent => 'Urgent';

  @override
  String get priorityHigh => 'High';

  @override
  String get priorityMedium => 'Medium';

  @override
  String get priorityLow => 'Low';

  @override
  String get endOfActiveTickets => 'End of active tickets';

  @override
  String get navMyTickets => 'My Tickets';

  @override
  String get navNewTicket => 'New Ticket';

  @override
  String get navQueue => 'Queue';

  @override
  String get navOverview => 'Overview';

  @override
  String get navSupport => 'Support';

  @override
  String get navArchive => 'Archive';

  @override
  String get tableHeaderId => 'ID';

  @override
  String get tableHeaderSubject => 'Subject';

  @override
  String get tableHeaderStatus => 'Status';

  @override
  String get tableHeaderPriority => 'Priority';

  @override
  String get tableHeaderUpdated => 'Updated';

  @override
  String get internalOps => 'Internal Ops';

  @override
  String get createTicketTitle => 'Submit a Request';

  @override
  String get createTicketSubtitle =>
      'Provide as much detail as possible so we can best assist you.';

  @override
  String get ticketSubject => 'Subject';

  @override
  String get ticketSubjectPlaceholder => 'Brief summary of your issue';

  @override
  String get ticketCategory => 'Category';

  @override
  String get ticketSelectCategory => 'Select a category';

  @override
  String get categoryTechnical => 'Technical Support';

  @override
  String get categoryBilling => 'Billing & Subscriptions';

  @override
  String get categoryAccount => 'Account Management';

  @override
  String get categoryGeneral => 'General Inquiry';

  @override
  String get ticketPriority => 'Priority';

  @override
  String get ticketDescription => 'Description';

  @override
  String get ticketDescriptionPlaceholder =>
      'Please describe your issue in detail...';

  @override
  String get ticketAttachments => 'Attachments';

  @override
  String get ticketUploadZoneHint =>
      'Tap to upload images or drop files here\n(Max 5MB per file, 25MB total)';

  @override
  String get submitTicket => 'Submit Ticket';

  @override
  String get subjectRequired => 'Please enter a subject';

  @override
  String get categoryRequired => 'Please select a category';

  @override
  String get descriptionRequired => 'Please enter a description';

  @override
  String get descriptionTooShort =>
      'Description must be at least 10 characters';

  @override
  String get fileSizeExceededError => 'A selected file exceeds the 5MB limit';

  @override
  String get totalSizeExceededError =>
      'Total attachments size exceeds the 25MB limit';

  @override
  String get ticketSubmittedSuccess => 'Ticket submitted successfully';

  @override
  String get loginSuccess => 'Logged in successfully';

  @override
  String get authErrorInvalidCredentials => 'Invalid email or password';

  @override
  String get authErrorEmailNotConfirmed =>
      'Email is not confirmed yet. Please check your inbox.';

  @override
  String get authErrorRateLimit =>
      'Too many attempts. Please wait a moment and try again.';

  @override
  String get authErrorGeneric => 'Authentication failed. Please try again.';

  @override
  String get buttonErrorFixFields => 'Please fix form errors';
}
