import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view_models/signup_states.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupStates());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();
  void handleSubmit({required BuildContext context, required bool isDesktop}) {
    if (formKey.currentState?.validate() ?? false) {
      //! <Where signup authentication submission should be handled>
      if (isDesktop) {
        context.pushReplacement('/desktop-drawer');
      } else {
        context.pushReplacement('/bottom-nav');
      }
    }
  }
}
