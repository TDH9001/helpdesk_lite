import 'package:flutter/material.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app_theme/app_theme_colors.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/data/model/customer_auth_static_model.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/widgets/auth_app_bar_widget.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/widgets/auth_card_widget.dart';

/// Mobile layout for customer authentication with top branding bar and scrollable auth card.
class CustomerAuthenticationMobile extends StatelessWidget {
  final CustomerAuthStaticModel staticData;

  const CustomerAuthenticationMobile({
    super.key,
    required this.staticData,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors =
        Theme.of(context).extension<AppThemeColors>()!.colors;

    return Scaffold(
      backgroundColor: widgetColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AuthAppBarWidget(
              title: staticData.myTicketsTitle,
              isDesktop: false,
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: AuthCardWidget(
                    staticData: staticData,
                    isDesktop: false,
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
