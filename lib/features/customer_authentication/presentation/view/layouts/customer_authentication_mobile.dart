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
import 'package:helpdesk_lite/features/customer_authentication/presentation/view_models/signup_cubit.dart';

/// Mobile layout for customer authentication with top branding bar and scrollable auth card.
class CustomerAuthenticationMobile extends StatefulWidget {
  final CustomerAuthStaticModel staticData;

  const CustomerAuthenticationMobile({super.key, required this.staticData});

  @override
  State<CustomerAuthenticationMobile> createState() =>
      _CustomerAuthenticationMobileState();
}

class _CustomerAuthenticationMobileState
    extends State<CustomerAuthenticationMobile> {
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    return Scaffold(
      backgroundColor: widgetColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top navigation bar
            AuthAppBarWidget(
              title: widget.staticData.myTicketsTitle,
              isDesktop: false,
            ),
            // Scrollable authentication card and bottom controls
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _isLogin
                          ? BlocProvider<LoginCubit>(
                              create: (context) => LoginCubit(),
                              child: LoginCardWidget(
                                staticData: widget.staticData,
                                isDesktop: false,
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
                                isDesktop: false,
                                onSwitchToLogin: () {
                                  setState(() {
                                    _isLogin = true;
                                  });
                                },
                              ),
                            ),
                      const SizedBox(height: 16),
                      // Quick preference toggles (Language & Theme)
                      const Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 12,
                        runSpacing: 10,
                        children: [LanguageToggleWidget(), ThemeToggleWidget()],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
