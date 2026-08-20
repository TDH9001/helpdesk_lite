import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/splash/data/model/splash_model.dart';
import 'package:helpdesk_lite/features/splash/presentation/view/widgets/splash_logo_widget.dart';
import 'package:helpdesk_lite/features/splash/presentation/view/widgets/splash_progress_widget.dart';
import 'package:helpdesk_lite/features/splash/presentation/view/widgets/splash_title_widget.dart';

/// Desktop and tablet layout representation of the Splash Screen.
class SplashDesktop extends StatelessWidget {
  final SplashModel data;
  final double progress;
  final String currentStatus;

  const SplashDesktop({
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
          size: 140.0,
        ),
        const SizedBox(height: 28.0),
        SplashTitleWidget(
          title: data.title,
          titleAccent: data.titleAccent,
          subtitle: data.subtitle,
          isDesktop: true,
        ),
      ],
    );

    // Bottom loading progress and status
    final bottomSection = Positioned(
      bottom: 64.0,
      left: 0.0,
      right: 0.0,
      child: Center(
        child: SplashProgressWidget(
          progress: progress,
          statusText: currentStatus,
          isDesktop: true,
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
