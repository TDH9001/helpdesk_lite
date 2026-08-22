import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/responsive_service/respnsive_service.dart';
import 'package:helpdesk_lite/features/ticket_queue/data/repos/implementations/static_ticket_queue_repo.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view/layouts/ticket_queue_desktop.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view/layouts/ticket_queue_mobile.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view_model/ticket_queue_cubit.dart';

/// Screen entrypoint for the Ticket Queue feature providing [TicketQueueCubit].
class TicketQueueScreen extends StatelessWidget {
  const TicketQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final staticData = StaticTicketQueueRepository.getStaticData(context);

    return BlocProvider(
      create: (context) => TicketQueueCubit()..init(),
      child: ResponsiveService(
        mobile: (context) => TicketQueueMobile(staticData: staticData),
        desktop: (context) => TicketQueueDesktop(staticData: staticData),
      ),
    );
  }
}
