import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:helpdesk_lite/core/utils/authentication_service/authentication_service.dart';
import 'package:helpdesk_lite/core/utils/database_service/database_service.dart';
import 'package:helpdesk_lite/core/utils/local_storage_service/user_hive_box.dart';
import 'package:helpdesk_lite/core/utils/localization_service/app_localizations.dart';
import 'package:helpdesk_lite/core/utils/shared_models/user_model.dart';
import 'package:helpdesk_lite/core/utils/snackbar_service/snackbar_service.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view_models/signup_states.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupCubit extends Cubit<SignupStates> {
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }

  SignupCubit() : super(SignupStates());

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> handleSubmit({
    required BuildContext context,
    required bool isDesktop,
  }) async {
    if (state is SignupLoading) return;
    if (formKey.currentState?.validate() ?? false) {
      final l10n = AppLocalizations.of(context)!;
      try {
        //start by loading in the data
        emit(SignupLoading());
        AuthResponse response = await AuthenticationService().signup(
          type: UserType.user,
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (response.user != null) {
          //meaning user was created
          emit(SignupSuccess());
          dev.log(response.user!.id);
          //* adding the data of the user when they signUp
          final userData = await DatabaseService().getUserData(
            userId: response.user!.id,
          );
          dev.log(response.user!.id);
          await UserHiveBox.addUserDataToBox(model: userData);
          SnackBarService.showInfo(context, l10n.signupSuccess);
          if (isDesktop) {
            context.pushReplacement('/desktop-drawer');
          } else {
            context.pushReplacement('/bottom-nav');
          }
        } else {
          emit(SignupFailure());
          SnackBarService.showError(context, l10n.authErrorGeneric);
        }
      } on AuthException catch (e) {
        emit(SignupFailure());
        final messageLower = e.message.toLowerCase();

        final String errorMessage;
        if (messageLower.contains('already registered') ||
            messageLower.contains('already exists') ||
            e.code == 'user_already_exists') {
          errorMessage = l10n.authErrorUserAlreadyExists;
        } else if (messageLower.contains('weak') || e.code == 'weak_password') {
          errorMessage = l10n.authErrorWeakPassword;
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
        emit(SignupFailure());
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
