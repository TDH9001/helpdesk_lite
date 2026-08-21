import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/responsive_service/respnsive_service.dart';
import 'package:helpdesk_lite/features/create_ticket/data/repos/implementations/static_create_ticket_repo.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/layouts/create_ticket_desktop.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/layouts/create_ticket_mobile.dart';

/// Screen entrypoint for Create Ticket feature with responsive layout routing.
class CreateTicketScreen extends StatelessWidget {
  const CreateTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final staticData = StaticCreateTicketRepository.getStaticData(context);

    return ResponsiveService(
      mobile: (context) => CreateTicketMobile(staticData: staticData),
      desktop: (context) => CreateTicketDesktop(staticData: staticData),
    );
  }
}
