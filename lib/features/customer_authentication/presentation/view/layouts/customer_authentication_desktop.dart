import 'package:flutter/material.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app_theme/app_theme_colors.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/data/model/customer_auth_static_model.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/widgets/auth_app_bar_widget.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/widgets/auth_card_widget.dart';

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
          AuthAppBarWidget(
            title: staticData.myTicketsTitle,
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
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 32,
                    ),
                    child: AuthCardWidget(
                      staticData: staticData,
                      isDesktop: true,
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
