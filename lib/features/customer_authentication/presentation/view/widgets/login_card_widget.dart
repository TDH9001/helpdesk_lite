import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/customer_authentication/data/model/customer_auth_static_model.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view/widgets/auth_header_widget.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view/widgets/auth_submit_button_widget.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view/widgets/auth_tabs_widget.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view/widgets/auth_text_field_widget.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view_models/login_cubit.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view_models/login_states.dart';

/// Self-contained card widget for customer login form inputs and validations.
class LoginCardWidget extends StatefulWidget {
  final CustomerAuthStaticModel staticData;
  final bool isDesktop;
  final VoidCallback onSwitchToSignup;

  const LoginCardWidget({
    super.key,
    required this.staticData,
    required this.onSwitchToSignup,
    this.isDesktop = false,
  });

  @override
  State<LoginCardWidget> createState() => _LoginCardWidgetState();
}

class _LoginCardWidgetState extends State<LoginCardWidget> {
  bool _isPasswordObscured = true;

  static final RegExp _emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  @override
  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    final forgotStyle = widget.isDesktop
        ? AppFonts().desktopCustomerAuthenticationLabelInter12SemiBold(
            context,
            color: widgetColors.primary,
          )
        : AppFonts().mobileCustomerAuthenticationLabelInter11SemiBold(
            context,
            color: widgetColors.primary,
          );

    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        switch (state) {
          case LoginLoading _:
          case LoginSuccess _:
          case LoginFailure _:
          case AlreadyLoggedIn _:
          default:
            break;
        }
      },
      builder: (context, state) => Container(
        width: widget.isDesktop ? 440 : double.infinity,
        decoration: BoxDecoration(
          color: widgetColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widgetColors.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top login / sign-up navigation tabs
              AuthTabsWidget(
                isLogin: true,
                loginText: widget.staticData.loginTab,
                signupText: widget.staticData.signupTab,
                isDesktop: widget.isDesktop,
                onTabChanged: (isLoginTab) {
                  if (!isLoginTab) {
                    widget.onSwitchToSignup();
                  }
                },
              ),
              // Login Form Body
              Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: context.read<LoginCubit>().formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AuthHeaderWidget(
                        title: widget.staticData.loginTitle,
                        subtitle: widget.staticData.loginSubtitle,
                        isDesktop: widget.isDesktop,
                      ),
                      const SizedBox(height: 24),
                      // Email address input
                      AuthTextFieldWidget(
                        label: widget.staticData.emailLabel,
                        placeholder: widget.staticData.emailPlaceholder,
                        prefixIcon: Icons.mail_outline,
                        controller: context.read<LoginCubit>().emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        isDesktop: widget.isDesktop,
                        validator: (value) {
                          final email = value?.trim() ?? '';
                          if (email.isEmpty) {
                            return widget.staticData.emailRequired;
                          }
                          if (!_emailRegExp.hasMatch(email)) {
                            return widget.staticData.emailInvalid;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Password input with visibility toggle & forgot password
                      AuthTextFieldWidget(
                        label: widget.staticData.passwordLabel,
                        placeholder: widget.staticData.passwordPlaceholder,
                        prefixIcon: Icons.lock_outline,
                        controller: context
                            .read<LoginCubit>()
                            .passwordController,
                        isPassword: true,
                        isObscured: _isPasswordObscured,
                        onToggleObscured: () {
                          setState(() {
                            _isPasswordObscured = !_isPasswordObscured;
                          });
                        },
                        trailingAction: InkWell(
                          onTap: () {
                            //! <Where forgot password navigation should be handled>
                          },
                          child: Text(
                            widget.staticData.forgotPasswordText,
                            style: forgotStyle.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        isDesktop: widget.isDesktop,
                        validator: (value) {
                          final password = value ?? '';
                          if (password.isEmpty) {
                            return widget.staticData.passwordRequired;
                          }
                          if (password.length < 6) {
                            return widget.staticData.passwordTooShort;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      // Submit button
                      state is LoginLoading
                          ? CircularProgressIndicator()
                          : AuthSubmitButtonWidget(
                              text: widget.staticData.loginButtonText,
                              isDesktop: widget.isDesktop,
                              onPressed: () {
                                context.read<LoginCubit>().handleSubmit(
                                  isDesktop: widget.isDesktop,
                                  context: context,
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
