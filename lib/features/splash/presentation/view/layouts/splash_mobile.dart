import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/splash/data/model/splash_model.dart';
import 'package:helpdesk_lite/features/splash/presentation/view/widgets/splash_logo_widget.dart';
import 'package:helpdesk_lite/features/splash/presentation/view/widgets/splash_progress_widget.dart';
import 'package:helpdesk_lite/features/splash/presentation/view/widgets/splash_title_widget.dart';

/// Mobile layout representation of the Splash Screen.
class SplashMobile extends StatelessWidget {
  final SplashModel data;
  final double progress;
  final String currentStatus;

  const SplashMobile({
    super.key,
    required this.data,
    required this.progress,
    required this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Center branding content (logo, title, subtitle)
    final centerContent = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SplashLogoWidget(
          logoAsset: data.logoAsset,
          size: 120.0,
        ),
        const SizedBox(height: 24.0),
        SplashTitleWidget(
          title: data.title,
          titleAccent: data.titleAccent,
          subtitle: data.subtitle,
          isDesktop: false,
        ),
      ],
    );

    // Bottom loading progress and status
    final bottomSection = Positioned(
      bottom: 48.0,
      left: 0.0,
      right: 0.0,
      child: Center(
        child: SplashProgressWidget(
          progress: progress,
          statusText: currentStatus,
          isDesktop: false,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: widgetColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Center(child: centerContent),
            bottomSection,
          ],
        ),
      ),
    );
  }
}
