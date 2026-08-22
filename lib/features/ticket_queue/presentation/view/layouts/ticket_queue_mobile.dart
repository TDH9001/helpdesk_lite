import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_model.dart';
import 'package:helpdesk_lite/features/ticket_queue/data/model/ticket_queue_static_model.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view/widgets/ticket_queue_card_widget.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view/widgets/ticket_queue_filter_sheet_widget.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view_model/ticket_queue_cubit.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view_model/ticket_queue_states.dart';

/// Mobile layout for Ticket Queue rendered cleanly via [TicketQueueCubit].
class TicketQueueMobile extends StatelessWidget {
  final TicketQueueStaticModel staticData;

  const TicketQueueMobile({super.key, required this.staticData});

  String _statusLabel(TicketStatus s) {
    switch (s) {
      case TicketStatus.open:
        return staticData.statusOpen;
      case TicketStatus.pending:
        return staticData.statusPending;
      case TicketStatus.delayed:
        return staticData.statusDelayed;
      case TicketStatus.waiting:
        return staticData.statusWaiting;
      case TicketStatus.resolved:
        return staticData.statusResolved;
      case TicketStatus.closed:
        return staticData.statusClosed;
    }
  }

  String _priorityLabel(TicketPriority p) {
    switch (p) {
      case TicketPriority.urgent:
        return staticData.priorityUrgent;
      case TicketPriority.high:
        return staticData.priorityHigh;
      case TicketPriority.medium:
        return staticData.priorityMedium;
      case TicketPriority.low:
        return staticData.priorityLow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;
    final cubit = context.read<TicketQueueCubit>();

    return Scaffold(
      backgroundColor: widgetColors.background,
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
          onRefresh: cubit.fetchTickets,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: BlocBuilder<TicketQueueCubit, TicketQueueStates>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TicketQueueFilterSheetWidget(
                      searchPlaceholder: staticData.searchPlaceholder,
                      allActiveLabel: staticData.filterAllActive,
                      unassignedLabel: staticData.filterUnassigned,
                      highPriorityLabel: staticData.filterHighPriority,
                      selectedFilter: cubit.selectedFilter,
                      searchController: cubit.searchController,
                      onSearchChanged: cubit.setSearchQuery,
                      onFilterChanged: cubit.setFilter,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
                      child: _buildTicketsContent(context, cubit, state, widgetColors),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTicketsContent(
    BuildContext context,
    TicketQueueCubit cubit,
    TicketQueueStates state,
    dynamic widgetColors,
  ) {
    if (state is TicketQueueLoading) {
      return const Padding(
        padding: EdgeInsets.all(40.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (cubit.tickets.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0),
        child: Center(
          child: Text(
            staticData.noQueueTicketsFound,
            textAlign: TextAlign.center,
            style: AppFonts().mobileTicketQueueCardSubjectInter13Regular(
              context,
              color: widgetColors.onSurfaceVariant,
            ),
          ),
        ),
      );
    }
    return Column(
      children: [
        ...cubit.tickets.map(
          (ticket) => Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: TicketQueueCardWidget(
              ticket: ticket,
              statusLabel: _statusLabel(ticket.status),
              priorityLabel: _priorityLabel(ticket.priority),
              assignToMeLabel: staticData.assignToMe,
              onAssignTap: () => cubit.assignTicketToMe(
                context: context,
                ticket: ticket,
                successMessage: staticData.assignedToYouSuccess,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            staticData.endOfActiveTickets,
            style: AppFonts().mobileTicketQueueEndLabelInter13Regular(
              context,
              color: widgetColors.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
