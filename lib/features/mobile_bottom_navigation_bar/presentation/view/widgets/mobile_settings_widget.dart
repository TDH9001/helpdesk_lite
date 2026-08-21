import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/authentication_service/authentication_service.dart';
import 'package:helpdesk_lite/core/widgets/language_toggle_widget.dart';
import 'package:helpdesk_lite/core/widgets/theme_toggle_widget.dart';
import 'package:helpdesk_lite/features/mobile_bottom_navigation_bar/data/model/mobile_bottom_nav_static_model.dart';

/// Settings screen for mobile bottom navigation with theme, language, and sign out controls.
class MobileSettingsWidget extends StatelessWidget {
  final MobileBottomNavStaticModel staticData;

  const MobileSettingsWidget({
    super.key,
    required this.staticData,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    final user = AuthenticationService().getCurrentUser();
    final userEmail = user?.email ?? '';

    final sectionLabelStyle =
        AppFonts().mobileCustomerAuthenticationLabelInter11SemiBold(
      context,
      color: widgetColors.onSurface,
    );

    final signOutStyle =
        AppFonts().mobileCustomerAuthenticationButtonInter12Medium(
      context,
      color: widgetColors.error,
    );

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      children: [
        // Header profile section with avatar and user details
        Center(
          child: Column(
            children: [
              Container(
                width: 68.0,
                height: 68.0,
                decoration: BoxDecoration(
                  color: widgetColors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_rounded,
                  size: 36.0,
                  color: widgetColors.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 12.0),
              if (userEmail.isNotEmpty)
                Text(
                  userEmail,
                  style: AppFonts()
                      .mobileCustomerAuthenticationTitleInter20SemiBold(
                    context,
                    color: widgetColors.onSurface,
                  ),
                ),
              const SizedBox(height: 4.0),
              Text(
                staticData.settingsSubtitle,
                style: AppFonts()
                    .mobileCustomerAuthenticationSubtitleInter13Regular(
                  context,
                  color: widgetColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32.0),

        // Preferences section for Theme and Language
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: widgetColors.surface,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: widgetColors.outlineVariant.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    staticData.appearanceSection,
                    style: sectionLabelStyle,
                  ),
                  const ThemeToggleWidget(),
                ],
              ),
              const Divider(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    staticData.languageSection,
                    style: sectionLabelStyle,
                  ),
                  const LanguageToggleWidget(),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24.0),

        // Sign out button
        OutlinedButton.icon(
          onPressed: () async {
            //! <Where mobile signout task should be handled>
            await AuthenticationService().logout();
            if (context.mounted) {
              context.go('/customer-auth');
            }
          },
          icon: Icon(Icons.logout_rounded, color: widgetColors.error),
          label: Text(
            staticData.signOut,
            style: signOutStyle,
          ),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            side: BorderSide(color: widgetColors.error.withValues(alpha: 0.5)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }
}
