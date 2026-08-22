import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/responsive_service/respnsive_service.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_model.dart';
import 'package:helpdesk_lite/features/customer_chat/data/repos/implementations/static_customer_chat_repo.dart';
import 'package:helpdesk_lite/features/customer_chat/presentation/view/layouts/customer_chat_desktop.dart';
import 'package:helpdesk_lite/features/customer_chat/presentation/view/layouts/customer_chat_mobile.dart';
import 'package:helpdesk_lite/features/customer_chat/presentation/view_model/customer_chat_cubit.dart';

/// Screen entry point for Customer Chat providing state injection and responsive layout routing.
class CustomerChatScreen extends StatelessWidget {
  final TicketModel ticket;

  const CustomerChatScreen({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final staticData = StaticCustomerChatRepository.getStaticData(context);

    return BlocProvider(
      create: (context) => CustomerChatCubit(ticket: ticket)..init(),
      child: ResponsiveService(
        mobile: (context) => CustomerChatMobile(staticData: staticData),
        desktop: (context) => CustomerChatDesktop(staticData: staticData),
      ),
    );
  }
}
