import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view_models/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginStates());
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void handleSubmit({required bool isDesktop, required BuildContext context}) {
    if (formKey.currentState?.validate() ?? false) {
      //! <Where login authentication submission should be handled>
      if (isDesktop) {
        context.pushReplacement('/desktop-drawer');
      } else {
        context.pushReplacement('/bottom-nav');
      }
    }
  }
}
