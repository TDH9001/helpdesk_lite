import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/my_tickets/data/model/my_tickets_static_model.dart';
import 'package:helpdesk_lite/features/my_tickets/data/model/ticket_model.dart';
import 'package:helpdesk_lite/features/my_tickets/presentation/view/widgets/my_tickets_app_bar_mobile.dart';
import 'package:helpdesk_lite/features/my_tickets/presentation/view/widgets/my_tickets_end_indicator.dart';
import 'package:helpdesk_lite/features/my_tickets/presentation/view/widgets/my_tickets_filter_chips.dart';
import 'package:helpdesk_lite/features/my_tickets/presentation/view/widgets/my_tickets_search_bar.dart';
import 'package:helpdesk_lite/features/my_tickets/presentation/view/widgets/ticket_card_mobile.dart';

/// Mobile layout representation of the My Tickets screen.
class MyTicketsMobile extends StatefulWidget {
  final MyTicketsStaticModel staticData;

  const MyTicketsMobile({super.key, required this.staticData});

  @override
  State<MyTicketsMobile> createState() => _MyTicketsMobileState();
}

class _MyTicketsMobileState extends State<MyTicketsMobile> {
  TicketStatus? _selectedStatus;
  //* begns as null, meaning all of them are to be seen
  String _searchQuery = '';

  String _getStatusLabel(TicketStatus status) {
    switch (status) {
      case TicketStatus.open:
        return widget.staticData.statusOpen;
      case TicketStatus.pending:
        return widget.staticData.statusPending;
      case TicketStatus.delayed:
        return widget.staticData.statusDelayed;
      case TicketStatus.waiting:
        return widget.staticData.statusWaiting;
      case TicketStatus.resolved:
        return widget.staticData.statusResolved;
      case TicketStatus.closed:
        return widget.staticData.statusClosed;
    }
  }

  String _getPriorityLabel(TicketPriority priority) {
    switch (priority) {
      case TicketPriority.urgent:
        return widget.staticData.priorityUrgent;
      case TicketPriority.high:
        return widget.staticData.priorityHigh;
      case TicketPriority.medium:
        return widget.staticData.priorityMedium;
      case TicketPriority.low:
        return widget.staticData.priorityLow;
    }
  }

  //* this adds to the list the items that have " matchesStatus = _selectedStatus"
  //* which is how the void callback works
  //* as the void callback simply goes to the parent's state and changes it
  //?   onTap: () => onStatusSelected?.call(TicketStatus.waiting),
  //? this means, got to parent, make
  //? onStatusSelected: (status) => setState(() => _selectedStatus = status),
  //? meaning that it simply says, only show this status

  //! AKA, the callback is a way to call a func in the parent class
  //! making it setState to a diffeent value
  List<TicketModel> get _filteredTickets {
    return widget.staticData.tickets.where((ticket) {
      final matchesStatus =
          _selectedStatus == null || ticket.status == _selectedStatus;
      final matchesSearch =
          _searchQuery.isEmpty ||
          ticket.code.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          ticket.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesStatus && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Header title and subtitle section
    final headerSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.staticData.yourTicketsTitle,
          style: AppFonts().mobileMyTicketsTitleInter24SemiBold(
            context,
            color: widgetColors.onBackground,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          widget.staticData.yourTicketsSubtitle,
          style: AppFonts().mobileMyTicketsSubtitleInter14Regular(
            context,
            color: widgetColors.onSurfaceVariant,
          ),
        ),
      ],
    );

    // Search and status filter pills section
    final filterSection = Column(
      children: [
        MyTicketsSearchBar(
          placeholder: widget.staticData.searchPlaceholder,
          onChanged: (query) => setState(() => _searchQuery = query),
        ),
        const SizedBox(height: 12.0),
        MyTicketsFilterChips(
          allActiveLabel: widget.staticData.filterAllActive,
          openLabel: widget.staticData.filterOpen,
          pendingLabel: widget.staticData.filterPending,
          waitingLabel: widget.staticData.filterWaiting,
          dateLabel: widget.staticData.filterDate,
          selectedStatus: _selectedStatus,
          onStatusSelected: (status) =>
              setState(() => _selectedStatus = status),
        ),
      ],
    );

    // Ticket cards list section
    final ticketsList = Column(
      children: _filteredTickets.map((ticket) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: TicketCardMobile(
            ticket: ticket,
            statusLabel: _getStatusLabel(ticket.status),
            priorityLabel: _getPriorityLabel(ticket.priority),
            onTap: () {
              //! <Where ticket detail navigation should be handled>
            },
          ),
        );
      }).toList(),
    );

    return Scaffold(
      backgroundColor: widgetColors.background,
      appBar: MyTicketsAppBarMobile(title: widget.staticData.myTicketsTitle),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              headerSection,
              const SizedBox(height: 16.0),
              filterSection,
              const SizedBox(height: 16.0),
              ticketsList,
              MyTicketsEndIndicator(
                label: widget.staticData.endOfActiveTickets,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
