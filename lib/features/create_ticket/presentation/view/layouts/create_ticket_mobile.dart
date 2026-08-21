import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/create_ticket/data/model/create_ticket_static_model.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/widgets/create_ticket_form_card_widget.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/widgets/create_ticket_header_widget.dart';

/// Mobile layout for Create Ticket screen.
class CreateTicketMobile extends StatelessWidget {
  final CreateTicketStaticModel staticData;

  const CreateTicketMobile({super.key, required this.staticData});

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Header section
    final headerSection = CreateTicketHeaderWidget(
      title: staticData.headerTitle,
      subtitle: staticData.headerSubtitle,
      isDesktop: false,
    );

    // Form card section
    final formSection = CreateTicketFormCardWidget(
      staticData: staticData,
      isDesktop: false,
    );

    return Scaffold(
      backgroundColor: widgetColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerSection,
              const SizedBox(height: 16.0),
              formSection,
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}
