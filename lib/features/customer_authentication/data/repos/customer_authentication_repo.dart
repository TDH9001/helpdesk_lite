import 'package:flutter/widgets.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/localization_service/app_localizations.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/data/model/customer_auth_model.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/data/model/customer_auth_static_model.dart';

abstract class CustomerAuthenticationRepo {
  Future<CustomerAuthStaticModel> getCustomerAuthStaticData(
    BuildContext context,
  );

  Future<CustomerAuthModel> login({
    required String email,
    required String password,
  });

  Future<CustomerAuthModel> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<void> forgotPassword({
    required String email,
  });
}

class StaticCustomerAuthenticationRepository
    implements CustomerAuthenticationRepo {
  const StaticCustomerAuthenticationRepository();

  static CustomerAuthStaticModel getStaticData(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CustomerAuthStaticModel(
      appTitle: l10n.appName,
      myTicketsTitle: l10n.myTickets,
      loginTab: l10n.logIn,
      signupTab: l10n.signUp,
      loginTitle: l10n.welcomeBack,
      loginSubtitle: l10n.loginSubtitle,
      signupTitle: l10n.createAccount,
      signupSubtitle: l10n.signupSubtitle,
      emailLabel: l10n.emailAddress,
      emailPlaceholder: l10n.emailPlaceholder,
      passwordLabel: l10n.password,
      passwordPlaceholder: l10n.passwordPlaceholder,
      confirmPasswordLabel: l10n.confirmPassword,
      forgotPasswordText: l10n.forgotPassword,
      loginButtonText: l10n.logIn,
      signupButtonText: l10n.signUp,
      havingTroubleText: l10n.havingTrouble,
      contactSupportText: l10n.contactSupport,
    );
  }

  @override
  Future<CustomerAuthStaticModel> getCustomerAuthStaticData(
    BuildContext context,
  ) async {
    return getStaticData(context);
  }

  @override
  Future<CustomerAuthModel> login({
    required String email,
    required String password,
  }) async {
    //! <Where login API integration should be handled>
    return CustomerAuthModel(
      email: email,
      token: 'mock_token',
      userId: 'mock_user_id',
    );
  }

  @override
  Future<CustomerAuthModel> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    //! <Where signup API integration should be handled>
    return CustomerAuthModel(
      email: email,
      token: 'mock_token',
      userId: 'mock_user_id',
    );
  }

  @override
  Future<void> forgotPassword({
    required String email,
  }) async {
    //! <Where password reset API integration should be handled>
  }
}
