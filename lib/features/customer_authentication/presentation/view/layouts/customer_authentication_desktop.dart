import 'package:flutter/material.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app_theme/app_theme_colors.dart';
import 'package:mvvvm_template_with_basic_services/core/widgets/language_toggle_widget.dart';
import 'package:mvvvm_template_with_basic_services/core/widgets/theme_toggle_widget.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/data/model/customer_auth_static_model.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/widgets/auth_app_bar_widget.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/widgets/auth_card_widget.dart';

/// Desktop layout for customer authentication, providing a centered
/// authentication card with ambient background glow and top branding bar.
class CustomerAuthenticationDesktop extends StatelessWidget {
  final CustomerAuthStaticModel staticData;

  const CustomerAuthenticationDesktop({
    super.key,
    required this.staticData,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors =
        Theme.of(context).extension<AppThemeColors>()!.colors;

    return Scaffold(
      backgroundColor: widgetColors.background,
      body: Column(
        children: [
          // Top navigation bar
          AuthAppBarWidget(
            title: staticData.appTitle,
            isDesktop: true,
          ),
          Expanded(
            child: Stack(
              children: [
                // Subtle decorative background ambient glow / grid
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: 600,
                      height: 600,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            widgetColors.primaryContainer
                                .withValues(alpha: 0.12),
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
                        AuthCardWidget(
                          staticData: staticData,
                          isDesktop: true,
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
