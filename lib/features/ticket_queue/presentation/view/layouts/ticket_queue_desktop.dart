import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_model.dart';
import 'package:helpdesk_lite/features/ticket_queue/data/model/ticket_queue_static_model.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view/widgets/ticket_queue_filter_chips_widget.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view/widgets/ticket_queue_table_row_desktop_widget.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view_model/ticket_queue_cubit.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view_model/ticket_queue_states.dart';

/// Desktop layout for Ticket Queue rendered cleanly via [TicketQueueCubit].
class TicketQueueDesktop extends StatelessWidget {
  final TicketQueueStaticModel staticData;

  const TicketQueueDesktop({super.key, required this.staticData});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: BlocBuilder<TicketQueueCubit, TicketQueueStates>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeaderToolbar(context, cubit, widgetColors),
                const SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    color: widgetColors.surface,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: widgetColors.outlineVariant.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildTableHeader(context, widgetColors),
                      _buildTableContent(context, cubit, state, widgetColors),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderToolbar(
    BuildContext context,
    TicketQueueCubit cubit,
    dynamic widgetColors,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          staticData.title,
          style: AppFonts().desktopTicketQueueTitleInter24Bold(
            context,
            color: widgetColors.onBackground,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          staticData.subtitle,
          style: AppFonts().desktopTicketQueueSubtitleInter13Regular(
            context,
            color: widgetColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 40.0,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: widgetColors.surface,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: widgetColors.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_rounded,
                      size: 18.0,
                      color: widgetColors.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextField(
                        controller: cubit.searchController,
                        onChanged: cubit.setSearchQuery,
                        style:
                            AppFonts().desktopTicketQueueSearchInter13Regular(
                          context,
                          color: widgetColors.onSurface,
                        ),
                        decoration: InputDecoration(
                          hintText: staticData.searchDesktopPlaceholder,
                          hintStyle: AppFonts()
                              .desktopTicketQueueSearchInter13Regular(
                            context,
                            color: widgetColors.onSurfaceVariant
                                .withValues(alpha: 0.6),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            TicketQueueFilterChipsWidget(
              allActiveLabel: staticData.filterAllActive,
              unassignedLabel: staticData.filterUnassigned,
              highPriorityLabel: staticData.filterHighPriority,
              selectedFilter: cubit.selectedFilter,
              onFilterChanged: cubit.setFilter,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTableHeader(BuildContext context, dynamic widgetColors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: widgetColors.surfaceContainerLow,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
        border: Border(
          bottom: BorderSide(
            color: widgetColors.outlineVariant.withValues(alpha: 0.35),
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100.0,
            child: Text(
              staticData.tableHeaderId,
              style: AppFonts().desktopTicketQueueTableHeaderInter11SemiBold(
                context,
                color: widgetColors.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(
            width: 150.0,
            child: Text(
              staticData.tableHeaderCustomer,
              style: AppFonts().desktopTicketQueueTableHeaderInter11SemiBold(
                context,
                color: widgetColors.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              staticData.tableHeaderSubject,
              style: AppFonts().desktopTicketQueueTableHeaderInter11SemiBold(
                context,
                color: widgetColors.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          SizedBox(
            width: 110.0,
            child: Text(
              staticData.tableHeaderStatus,
              textAlign: TextAlign.center,
              style: AppFonts().desktopTicketQueueTableHeaderInter11SemiBold(
                context,
                color: widgetColors.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          SizedBox(
            width: 90.0,
            child: Text(
              staticData.tableHeaderPriority,
              textAlign: TextAlign.center,
              style: AppFonts().desktopTicketQueueTableHeaderInter11SemiBold(
                context,
                color: widgetColors.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          SizedBox(
            width: 140.0,
            child: Text(
              staticData.tableHeaderAssignee,
              style: AppFonts().desktopTicketQueueTableHeaderInter11SemiBold(
                context,
                color: widgetColors.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          SizedBox(
            width: 90.0,
            child: Text(
              staticData.tableHeaderUpdated,
              textAlign: TextAlign.end,
              style: AppFonts().desktopTicketQueueTableHeaderInter11SemiBold(
                context,
                color: widgetColors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableContent(
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
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Center(
          child: Text(
            staticData.noQueueTicketsFound,
            style: AppFonts().desktopTicketQueueSubtitleInter13Regular(
              context,
              color: widgetColors.onSurfaceVariant,
            ),
          ),
        ),
      );
    }
    return Column(
      children: cubit.tickets
          .map(
            (ticket) => TicketQueueTableRowDesktopWidget(
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
          )
          .toList(),
    );
  }
}
