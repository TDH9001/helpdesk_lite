import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/widgets/language_toggle_widget.dart';
import 'package:helpdesk_lite/core/widgets/theme_toggle_widget.dart';
import 'package:helpdesk_lite/features/customer_authentication/data/model/customer_auth_static_model.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view/widgets/auth_app_bar_widget.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view/widgets/login_card_widget.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view/widgets/signup_card_widget.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view_models/login_cubit.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view_models/login_states.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view_models/signup_cubit.dart';

/// Desktop layout for customer authentication, providing a centered
/// authentication card with ambient background glow and top branding bar.
class CustomerAuthenticationDesktop extends StatefulWidget {
  final CustomerAuthStaticModel staticData;

  const CustomerAuthenticationDesktop({super.key, required this.staticData});

  @override
  State<CustomerAuthenticationDesktop> createState() =>
      _CustomerAuthenticationDesktopState();
}

class _CustomerAuthenticationDesktopState
    extends State<CustomerAuthenticationDesktop> {
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    return Scaffold(
      backgroundColor: widgetColors.background,
      body: Column(
        children: [
          // Top navigation bar
          AuthAppBarWidget(title: widget.staticData.appTitle, isDesktop: true),
          Expanded(
            child: Stack(
              children: [
                // Subtle decorative background ambient glow
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: 600,
                      height: 600,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            widgetColors.primaryContainer.withValues(
                              alpha: 0.12,
                            ),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Main authentication card and bottom controls
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 32,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _isLogin
                            ? BlocProvider<LoginCubit>(
                                create: (context) => LoginCubit(),
                                child: LoginCardWidget(
                                  staticData: widget.staticData,
                                  isDesktop: true,
                                  onSwitchToSignup: () {
                                    setState(() {
                                      _isLogin = false;
                                    });
                                  },
                                ),
                              )
                            : BlocProvider<SignupCubit>(
                                create: (context) => SignupCubit(),
                                child: SignupCardWidget(
                                  staticData: widget.staticData,
                                  isDesktop: true,
                                  onSwitchToLogin: () {
                                    setState(() {
                                      _isLogin = true;
                                    });
                                  },
                                ),
                              ),
                        const SizedBox(height: 20),
                        // Quick preference toggles (Language & Theme)
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LanguageToggleWidget(),
                            SizedBox(width: 12),
                            ThemeToggleWidget(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
