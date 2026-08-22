class CustomerAuthStaticModel {
  final String appTitle;
  final String myTicketsTitle;
  final String loginTab;
  final String signupTab;
  final String loginTitle;
  final String loginSubtitle;
  final String signupTitle;
  final String signupSubtitle;
  final String usernameLabel;
  final String usernamePlaceholder;
  final String emailLabel;
  final String emailPlaceholder;
  final String passwordLabel;
  final String passwordPlaceholder;
  final String confirmPasswordLabel;
  final String forgotPasswordText;
  final String loginButtonText;
  final String signupButtonText;
  final String havingTroubleText;
  final String contactSupportText;

  // Validation strings
  final String usernameRequired;
  final String emailRequired;
  final String emailInvalid;
  final String passwordRequired;
  final String passwordTooShort;
  final String confirmPasswordRequired;
  final String passwordsDoNotMatch;

  const CustomerAuthStaticModel({
    required this.appTitle,
    required this.myTicketsTitle,
    required this.loginTab,
    required this.signupTab,
    required this.loginTitle,
    required this.loginSubtitle,
    required this.signupTitle,
    required this.signupSubtitle,
    required this.usernameLabel,
    required this.usernamePlaceholder,
    required this.emailLabel,
    required this.emailPlaceholder,
    required this.passwordLabel,
    required this.passwordPlaceholder,
    required this.confirmPasswordLabel,
    required this.forgotPasswordText,
    required this.loginButtonText,
    required this.signupButtonText,
    required this.havingTroubleText,
    required this.contactSupportText,
    required this.usernameRequired,
    required this.emailRequired,
    required this.emailInvalid,
    required this.passwordRequired,
    required this.passwordTooShort,
    required this.confirmPasswordRequired,
    required this.passwordsDoNotMatch,
  });
}
