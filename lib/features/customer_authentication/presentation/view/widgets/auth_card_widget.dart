import 'package:flutter/material.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app%20fonts/app_fonts.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app_theme/app_theme_colors.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/data/model/customer_auth_static_model.dart';
// import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/widgets/auth_footer_widget.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/widgets/auth_header_widget.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/widgets/auth_submit_button_widget.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/widgets/auth_tabs_widget.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/widgets/auth_text_field_widget.dart';

class AuthCardWidget extends StatefulWidget {
  final CustomerAuthStaticModel staticData;
  final bool isDesktop;

  const AuthCardWidget({
    super.key,
    required this.staticData,
    this.isDesktop = false,
  });

  @override
  State<AuthCardWidget> createState() => _AuthCardWidgetState();
}

class _AuthCardWidgetState extends State<AuthCardWidget> {
  bool _isLogin = true;
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widgetColors =
        Theme.of(context).extension<AppThemeColors>()!.colors;

    final forgotStyle = widget.isDesktop
        ? AppFonts().desktopCustomerAuthenticationLabelInter12SemiBold(
            context,
            color: widgetColors.primary,
          )
        : AppFonts().mobileCustomerAuthenticationLabelInter11SemiBold(
            context,
            color: widgetColors.primary,
          );

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
            AuthTabsWidget(
              isLogin: _isLogin,
              loginText: widget.staticData.loginTab,
              signupText: widget.staticData.signupTab,
              isDesktop: widget.isDesktop,
              onTabChanged: (isLoginTab) {
                setState(() {
                  _isLogin = isLoginTab;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AuthHeaderWidget(
                    title: _isLogin
                        ? widget.staticData.loginTitle
                        : widget.staticData.signupTitle,
                    subtitle: _isLogin
                        ? widget.staticData.loginSubtitle
                        : widget.staticData.signupSubtitle,
                    isDesktop: widget.isDesktop,
                  ),
                  const SizedBox(height: 24),
                  AuthTextFieldWidget(
                    label: widget.staticData.emailLabel,
                    placeholder: widget.staticData.emailPlaceholder,
                    prefixIcon: Icons.mail_outline,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    isDesktop: widget.isDesktop,
                  ),
                  const SizedBox(height: 16),
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
                    trailingAction: _isLogin
                        ? InkWell(
                            onTap: () {
                              //! <Where forgot password navigation should be handled>
                            },
                            child: Text(
                              widget.staticData.forgotPasswordText,
                              style: forgotStyle.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        : null,
                    textInputAction: _isLogin
                        ? TextInputAction.done
                        : TextInputAction.next,
                    isDesktop: widget.isDesktop,
                  ),
                  if (!_isLogin) const SizedBox(height: 16),
                  if (!_isLogin)
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
                    ),
                  const SizedBox(height: 24),
                  AuthSubmitButtonWidget(
                    text: _isLogin
                        ? widget.staticData.loginButtonText
                        : widget.staticData.signupButtonText,
                    isDesktop: widget.isDesktop,
                    onPressed: () {
                      //! <Where authentication submit should be handled>
                    },
                  ),
                  // AuthFooterWidget is excluded from the current design for now
                  // const SizedBox(height: 20),
                  // AuthFooterWidget(
                  //   havingTroubleText: widget.staticData.havingTroubleText,
                  //   contactSupportText: widget.staticData.contactSupportText,
                  //   isDesktop: widget.isDesktop,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
