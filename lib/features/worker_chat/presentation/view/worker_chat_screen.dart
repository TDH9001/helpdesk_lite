import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/responsive_service/respnsive_service.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_model.dart';
import 'package:helpdesk_lite/features/worker_chat/data/repos/implementations/static_worker_chat_repo.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/layouts/worker_chat_desktop.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/layouts/worker_chat_mobile.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view_model/worker_chat_cubit.dart';

/// Screen entry point for Worker Chat providing state injection and responsive layout routing.
class WorkerChatScreen extends StatelessWidget {
  final TicketModel ticket;

  const WorkerChatScreen({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final staticData = StaticWorkerChatRepository.getStaticData(context);

    return BlocProvider(
      create: (context) => WorkerChatCubit(ticket: ticket)..init(),
      child: ResponsiveService(
        mobile: (context) => WorkerChatMobile(staticData: staticData),
        tablet: (context) => WorkerChatMobile(staticData: staticData),
        desktop: (context) => WorkerChatDesktop(staticData: staticData),
      ),
    );
  }
}
