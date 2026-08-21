import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/authentication_service/authentication_service.dart';
import 'package:helpdesk_lite/core/utils/localization_service/app_localizations.dart';
import 'package:helpdesk_lite/core/utils/shared_models/user_model.dart';
import 'package:helpdesk_lite/core/utils/snackbar_service/snackbar_service.dart';
import 'package:helpdesk_lite/features/add_new_agent/presentation/view_model/add_new_agent_states.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Cubit managing agent creation form input, role selection, and submission.
class AddNewAgentCubit extends Cubit<AddNewAgentStates> {
  AddNewAgentCubit() : super(AddNewAgentInitial());

  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  UserType selectedRole = UserType.worker;

  void selectRole(UserType role) {
    selectedRole = role;
    emit(AddNewAgentInitial());
  }

  Future<void> handleSubmit({
    required BuildContext context,
    VoidCallback? onSuccess,
  }) async {
    if (state is AddNewAgentLoading) return;

    if (formKey.currentState?.validate() ?? false) {
      final l10n = AppLocalizations.of(context)!;
      try {
        emit(AddNewAgentLoading());

        final nameText = nameController.text.trim();
        final emailText = emailController.text.trim();
        final passwordText = passwordController.text.trim();

        final response = await AuthenticationService().signup(
          type: selectedRole,
          email: emailText,
          password: passwordText,
          fullName: nameText.isNotEmpty ? nameText : null,
        );

        if (response.user != null) {
          //new user created and now not= null
          emit(AddNewAgentSuccess());
          final successMessage = selectedRole == UserType.manager
              ? l10n.managerCreatedSuccess
              : l10n.workerCreatedSuccess;
          SnackBarService.showInfo(context, successMessage);
          onSuccess?.call();
        } else {
          emit(AddNewAgentFailure());
          SnackBarService.showError(context, l10n.authErrorGeneric);
        }
      } on AuthException catch (e) {
        emit(AddNewAgentFailure());
        final messageLower = e.message.toLowerCase();

        final String errorMessage;
        if (messageLower.contains('already registered') ||
            messageLower.contains('already exists') ||
            e.code == 'user_already_exists') {
          errorMessage = l10n.authErrorUserAlreadyExists;
        } else if (messageLower.contains('weak') ||
            e.code == 'weak_password') {
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
          errorMessage =
              e.message.isNotEmpty ? e.message : l10n.authErrorGeneric;
        }

        SnackBarService.showError(context, errorMessage);
      } catch (e) {
        emit(AddNewAgentFailure());
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

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
