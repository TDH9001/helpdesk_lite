import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/customer_authentication/data/model/customer_auth_static_model.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view/widgets/auth_header_widget.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view/widgets/auth_submit_button_widget.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view/widgets/auth_tabs_widget.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view/widgets/auth_text_field_widget.dart';

/// Self-contained card widget for customer sign up form inputs and validations.
class SignupCardWidget extends StatefulWidget {
  final CustomerAuthStaticModel staticData;
  final bool isDesktop;
  final VoidCallback onSwitchToLogin;

  const SignupCardWidget({
    super.key,
    required this.staticData,
    required this.onSwitchToLogin,
    this.isDesktop = false,
  });

  @override
  State<SignupCardWidget> createState() => _SignupCardWidgetState();
}

class _SignupCardWidgetState extends State<SignupCardWidget> {
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  static final RegExp _emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      //! <Where signup authentication submission should be handled>
      if (widget.isDesktop) {
        context.pushReplacement('/desktop-drawer');
      } else {
        context.pushReplacement('/bottom-nav');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final widgetColors =
        Theme.of(context).extension<AppThemeColors>()!.colors;

    return Container(
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
              isLogin: false,
              loginText: widget.staticData.loginTab,
              signupText: widget.staticData.signupTab,
              isDesktop: widget.isDesktop,
              onTabChanged: (isLoginTab) {
                if (isLoginTab) {
                  widget.onSwitchToLogin();
                }
              },
            ),
            // Sign Up Form Body
            Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AuthHeaderWidget(
                      title: widget.staticData.signupTitle,
                      subtitle: widget.staticData.signupSubtitle,
                      isDesktop: widget.isDesktop,
                    ),
                    const SizedBox(height: 24),
                    // Email address input
                    AuthTextFieldWidget(
                      label: widget.staticData.emailLabel,
                      placeholder: widget.staticData.emailPlaceholder,
                      prefixIcon: Icons.mail_outline,
                      controller: _emailController,
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
                    // Password input with visibility toggle
                    AuthTextFieldWidget(
                      label: widget.staticData.passwordLabel,
                      placeholder: widget.staticData.passwordPlaceholder,
                      prefixIcon: Icons.lock_outline,
                      controller: _passwordController,
                      isPassword: true,
                      isObscured: _isPasswordObscured,
                      onToggleObscured: () {
                        setState(() {
                          _isPasswordObscured = !_isPasswordObscured;
                        });
                      },
                      textInputAction: TextInputAction.next,
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
                    const SizedBox(height: 16),
                    // Confirm password input with visibility toggle & match validation
                    AuthTextFieldWidget(
                      label: widget.staticData.confirmPasswordLabel,
                      placeholder: widget.staticData.passwordPlaceholder,
                      prefixIcon: Icons.lock_reset_outlined,
                      controller: _confirmPasswordController,
                      isPassword: true,
                      isObscured: _isConfirmPasswordObscured,
                      onToggleObscured: () {
                        setState(() {
                          _isConfirmPasswordObscured =
                              !_isConfirmPasswordObscured;
                        });
                      },
                      textInputAction: TextInputAction.done,
                      isDesktop: widget.isDesktop,
                      validator: (value) {
                        final confirmPassword = value ?? '';
                        if (confirmPassword.isEmpty) {
                          return widget.staticData.confirmPasswordRequired;
                        }
                        if (confirmPassword != _passwordController.text) {
                          return widget.staticData.passwordsDoNotMatch;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    // Submit button
                    AuthSubmitButtonWidget(
                      text: widget.staticData.signupButtonText,
                      isDesktop: widget.isDesktop,
                      onPressed: _handleSubmit,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
