import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:helpdesk_lite/core/utils/authentication_service/authentication_service.dart';
import 'package:helpdesk_lite/core/utils/localization_service/app_localizations.dart';
import 'package:helpdesk_lite/core/utils/snackbar_service/snackbar_service.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view_models/login_states.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginCubit extends Cubit<LoginStates> {
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  LoginCubit() : super(LoginStates());
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> handleSubmit({
    required bool isDesktop,
    required BuildContext context,
  }) async {
    if (state is LoginLoading) return;
    if (formKey.currentState?.validate() ?? false) {
      final l10n = AppLocalizations.of(context)!;
      //! <Where login authentication submission should be handled>
      try {
        //start by laoding in the data
        emit(LoginLoading());
        AuthResponse response = await AuthenticationService().login(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        if (response.session != null && response.user != null) {
          //meaning a session exists and a user exists
          emit(LoginSuccess());
          dev.log(response.user!.id);
          SnackBarService.showInfo(context, l10n.loginSuccess);
          if (isDesktop) {
            context.pushReplacement('/desktop-drawer');
          } else {
            context.pushReplacement('/bottom-nav');
          }
        } else {
          emit(LoginFailure());
          SnackBarService.showError(context, l10n.authErrorGeneric);
        }
      } on AuthException catch (e) {
        emit(LoginFailure());
        final messageLower = e.message.toLowerCase();

        final String errorMessage;
        if (messageLower.contains('invalid login credentials') ||
            e.code == 'invalid_credentials') {
          errorMessage = l10n.authErrorInvalidCredentials;
        } else if (messageLower.contains('email not confirmed') ||
            e.code == 'email_not_confirmed') {
          errorMessage = l10n.authErrorEmailNotConfirmed;
        } else if (e.statusCode == '429' ||
            messageLower.contains('rate limit') ||
            messageLower.contains('too many')) {
          errorMessage = l10n.authErrorRateLimit;
        } else if (messageLower.contains('network') ||
            messageLower.contains('connection') ||
            messageLower.contains('socket')) {
          errorMessage = l10n.authErrorNetwork;
        } else {
          errorMessage = e.message.isNotEmpty
              ? e.message
              : l10n.authErrorGeneric;
        }

        SnackBarService.showError(context, errorMessage);
      } catch (e) {
        emit(LoginFailure());
        final isNetwork =
            e.toString().toLowerCase().contains('socket') ||
            e.toString().toLowerCase().contains('network') ||
            e.toString().toLowerCase().contains('clientexception');

        SnackBarService.showError(
          context,
          isNetwork ? l10n.authErrorNetwork : l10n.authErrorGeneric,
        );
      }
    }
  }
}
