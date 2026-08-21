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

  @override
  String get splashTitle => 'HelpDesk';

  @override
  String get splashTitleAccent => 'Lite';

  @override
  String get splashSubtitle => 'الدعم الفني، بكل بساطة.';

  @override
  String get splashStartingUp => 'جاري بدء التشغيل';

  @override
  String get splashConnecting => 'جاري الاتصال';

  @override
  String get splashReady => 'جاهز';

  @override
  String get yourTickets => 'تذاكرك';

  @override
  String get yourTicketsSubtitle => 'إدارة وتتبع طلبات الدعم النشطة الخاصة بك.';

  @override
  String get manageAssignedIssues => 'إدارة والرد على المشكلات المخصصة لك.';

  @override
  String get searchTicketsPlaceholder =>
      'ابحث في التذاكر أو المعرفات أو الكلمات المفتاحية...';

  @override
  String get searchTicketsDesktopPlaceholder =>
      'ابحث في التذاكر أو المعرفات أو المستخدمين...';

  @override
  String get filterAllActive => 'جميع النشطة';

  @override
  String get filterOpen => 'مفتوحة';

  @override
  String get filterPending => 'معلقة';

  @override
  String get filterWaiting => 'في الانتظار';

  @override
  String get filterDelayed => 'متأخرة';

  @override
  String get filterDate => 'التاريخ';

  @override
  String get statusOpen => 'مفتوحة';

  @override
  String get statusPending => 'معلقة';

  @override
  String get statusDelayed => 'متأخرة';

  @override
  String get statusWaiting => 'في الانتظار';

  @override
  String get statusResolved => 'تم الحل';

  @override
  String get statusClosed => 'مغلقة';

  @override
  String get priorityUrgent => 'عاجل';

  @override
  String get priorityHigh => 'مرتفع';

  @override
  String get priorityMedium => 'متوسط';

  @override
  String get priorityLow => 'منخفض';

  @override
  String get endOfActiveTickets => 'نهاية التذاكر النشطة';

  @override
  String get navMyTickets => 'تذاكري';

  @override
  String get navNewTicket => 'تذكرة جديدة';

  @override
  String get navQueue => 'قائمة الانتظار';

  @override
  String get navOverview => 'نظرة عامة';

  @override
  String get navSupport => 'الدعم';

  @override
  String get navArchive => 'الأرشيف';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsSubtitle => 'إدارة المظهر واللغة وجلسة الحساب.';

  @override
  String get appearanceSection => 'المظهر';

  @override
  String get languageSection => 'اللغة';

  @override
  String get accountSection => 'الحساب';

  @override
  String get tableHeaderId => 'المعرف';

  @override
  String get tableHeaderSubject => 'الموضوع';

  @override
  String get tableHeaderStatus => 'الحالة';

  @override
  String get tableHeaderPriority => 'الأولوية';

  @override
  String get tableHeaderUpdated => 'آخر تحديث';

  @override
  String get internalOps => 'العمليات الداخلية';

  @override
  String get createTicketTitle => 'تقديم طلب';

  @override
  String get createTicketSubtitle =>
      'يرجى تقديم أكبر قدر ممكن من التفاصيل لمساعدتك بالشكل الأفضل.';

  @override
  String get ticketSubject => 'الموضوع';

  @override
  String get ticketSubjectPlaceholder => 'ملخص موجز لمشكلتك';

  @override
  String get ticketCategory => 'الفئة';

  @override
  String get ticketSelectCategory => 'اختر الفئة';

  @override
  String get categoryTechnical => 'الدعم الفني';

  @override
  String get categoryBilling => 'الفواتير والاشتراكات';

  @override
  String get categoryAccount => 'إدارة الحساب';

  @override
  String get categoryGeneral => 'استفسار عام';

  @override
  String get ticketPriority => 'الأولوية';

  @override
  String get ticketDescription => 'الوصف';

  @override
  String get ticketDescriptionPlaceholder => 'يرجى وصف مشكلتك بالتفصيل...';

  @override
  String get ticketAttachments => 'المرفقات';

  @override
  String get ticketUploadZoneHint =>
      'انقر لتحميل الصور أو الملفات\n(الحد الأقصى 5 ميجابايت للملف، 25 ميجابايت إجمالي)';

  @override
  String get submitTicket => 'إرسال التذكرة';

  @override
  String get subjectRequired => 'يرجى إدخال الموضوع';

  @override
  String get categoryRequired => 'يرجى اختيار الفئة';

  @override
  String get descriptionRequired => 'يرجى إدخال الوصف';

  @override
  String get descriptionTooShort => 'يجب أن يتكون الوصف من 10 أحرف على الأقل';

  @override
  String get fileSizeExceededError =>
      'أحد الملفات المحددة يتجاوز الحد الأقصى 5 ميجابايت';

  @override
  String get totalSizeExceededError =>
      'إجمالي حجم المرفقات يتجاوز الحد الأقصى 25 ميجابايت';

  @override
  String get ticketSubmittedSuccess => 'تم إرسال التذكرة بنجاح';

  @override
  String get loginSuccess => 'تم تسجيل الدخول بنجاح';

  @override
  String get signupSuccess => 'تم إنشاء الحساب بنجاح!';

  @override
  String get authErrorInvalidCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة';

  @override
  String get authErrorEmailNotConfirmed =>
      'لم يتم تأكيد البريد الإلكتروني بعد. يرجى التحقق من بريدك الوارد.';

  @override
  String get authErrorRateLimit =>
      'تم تجاوز عدد المحاولات المسموح به. يرجى الانتظار قليلاً ثم المحاولة مرة أخرى.';

  @override
  String get authErrorNetwork =>
      'خطأ في الشبكة. يرجى التحقق من اتصالك بالإنترنت.';

  @override
  String get authErrorUserAlreadyExists =>
      'يوجد حساب مسجل بهذا البريد الإلكتروني بالفعل.';

  @override
  String get authErrorWeakPassword =>
      'كلمة المرور ضعيفة جداً. يرجى استخدام 6 أحرف على الأقل.';

  @override
  String get authErrorGeneric =>
      'فشلت عملية تسجيل الدخول. يرجى المحاولة مرة أخرى.';

  @override
  String get buttonErrorFixFields => 'يرجى تصحيح أخطاء النموذج';

  @override
  String get overviewTitle => 'نظرة عامة';

  @override
  String get overviewSubtitle => 'متابعة إنتاجية الفريق وحجم تذاكر النظام.';

  @override
  String get addNewAgent => 'إضافة وكيل جديد';

  @override
  String get totalOpenTickets => 'إجمالي التذاكر المفتوحة';

  @override
  String get totalOpenTicketsBadge => '+12%';

  @override
  String get createdThisWeek => 'تم إنشاؤها هذا الأسبوع';

  @override
  String get createdThisWeekCount => '384';

  @override
  String get vsLastWeek => 'مقارنة بـ 412 الأسبوع الماضي';

  @override
  String get ticketsPerAgent => 'التذاكر لكل وكيل';

  @override
  String agentTicketsCount(int count) {
    return '$count تذكرة';
  }

  @override
  String get noAgentsFound => 'لم يتم العثور على وكلاء';

  @override
  String get addNewAgentTitle => 'إنشاء حساب وكيل';

  @override
  String get addNewAgentSubtitle => 'إضافة وكيل دعم فني جديد للمنظومة.';

  @override
  String get agentNameLabel => 'الاسم أو اللقب';

  @override
  String get agentNameHint => 'مثال: سارة أحمد';

  @override
  String get agentRoleLabel => 'مستوى الدور';

  @override
  String get roleWorker => 'فني دعم';

  @override
  String get roleManager => 'مدير وردية';

  @override
  String get createAgentButton => 'إنشاء الوكيل';

  @override
  String get cancelButton => 'إلغاء';

  @override
  String get agentCreatedSuccess => 'تم إنشاء حساب الوكيل بنجاح';

  @override
  String get workerCreatedSuccess => 'تم إنشاء حساب الفني بنجاح';

  @override
  String get managerCreatedSuccess => 'تم إنشاء حساب المدير بنجاح';
}
