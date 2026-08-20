import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/responsive_service/respnsive_service.dart';
import 'package:helpdesk_lite/features/my_tickets/data/repos/implementations/static_my_tickets_repo.dart';
import 'package:helpdesk_lite/features/my_tickets/presentation/view/layouts/my_tickets_desktop.dart';
import 'package:helpdesk_lite/features/my_tickets/presentation/view/layouts/my_tickets_mobile.dart';

/// Screen entrypoint for the My Tickets feature, routing to mobile or desktop layout.
class MyTicketsScreen extends StatelessWidget {
  const MyTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final staticData = StaticMyTicketsRepository.getStaticData(context);

    return ResponsiveService(
      mobile: (context) => MyTicketsMobile(
        staticData: staticData,
      ),
      desktop: (context) => MyTicketsDesktop(
        staticData: staticData,
      ),
    );
  }
}
