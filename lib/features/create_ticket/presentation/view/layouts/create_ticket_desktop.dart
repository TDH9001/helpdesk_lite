import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/create_ticket/data/model/create_ticket_static_model.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/widgets/create_ticket_form_card_widget.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/widgets/create_ticket_header_widget.dart';

/// Desktop layout for Create Ticket screen with centered content and optimal max width.
class CreateTicketDesktop extends StatelessWidget {
  final CreateTicketStaticModel staticData;

  const CreateTicketDesktop({super.key, required this.staticData});

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Header section
    final headerSection = CreateTicketHeaderWidget(
      title: staticData.headerTitle,
      subtitle: staticData.headerSubtitle,
      isDesktop: true,
    );

    // Form card section
    final formSection = CreateTicketFormCardWidget(
      staticData: staticData,
      isDesktop: true,
    );

    return Scaffold(
      backgroundColor: widgetColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 32.0,
            vertical: 28.0,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerSection,
                  const SizedBox(height: 20.0),
                  formSection,
                  const SizedBox(height: 48.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
