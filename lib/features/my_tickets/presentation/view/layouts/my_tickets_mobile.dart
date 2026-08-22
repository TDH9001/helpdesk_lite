import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/database_service/database_service.dart';
import 'package:helpdesk_lite/core/utils/local_storage_service/user_hive_box.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_model.dart';
import 'package:helpdesk_lite/core/utils/shared_models/user_model.dart';
import 'package:helpdesk_lite/core/utils/snackbar_service/snackbar_service.dart';
import 'package:helpdesk_lite/features/my_tickets/data/model/my_tickets_static_model.dart';
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
  final DatabaseService _databaseService = DatabaseService();
  TicketStatus? _selectedStatus;
  String _searchQuery = '';
  List<TicketModel>? _tickets;
  bool _isLoading = true;
  UserModel? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserAndFetch();
  }

  Future<void> _loadUserAndFetch() async {
    _currentUser = await UserHiveBox.getUserData();
    await _fetchTickets();
  }

  Future<void> _fetchTickets() async {
    if (_currentUser == null) {
      setState(() => _isLoading = false);
      return;
    }
    setState(() => _isLoading = true);
    try {
      final fetched = await _databaseService.getMyTickets(
        userId: _currentUser!.id,
      );
      if (mounted) {
        setState(() {
          _tickets = fetched;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        SnackBarService.showError(context, e.toString());
      }
    }
  }

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

  List<TicketModel> get _filteredTickets {
    if (_tickets == null) return const [];
    return _tickets!.where((ticket) {
      final matchesStatus =
          _selectedStatus == null || ticket.status == _selectedStatus;
      final lower = _searchQuery.toLowerCase().trim();
      final matchesSearch = lower.isEmpty ||
          ticket.code.toLowerCase().contains(lower) ||
          ticket.title.toLowerCase().contains(lower) ||
          (ticket.category ?? '').toLowerCase().contains(lower) ||
          (ticket.description ?? '').toLowerCase().contains(lower);
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

    // Ticket cards list or loading / empty state
    Widget contentBody;
    if (_isLoading) {
      contentBody = const Padding(
        padding: EdgeInsets.all(40.0),
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (_filteredTickets.isEmpty) {
      contentBody = Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.inbox_outlined,
                size: 48.0,
                color: widgetColors.outlineVariant,
              ),
              const SizedBox(height: 12.0),
              Text(
                'No tickets found',
                style: AppFonts().mobileMyTicketsSubtitleInter14Regular(
                  context,
                  color: widgetColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      contentBody = Column(
        children: [
          ..._filteredTickets.map((ticket) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: TicketCardMobile(
                ticket: ticket,
                statusLabel: _getStatusLabel(ticket.status),
                priorityLabel: _getPriorityLabel(ticket.priority),
                onTap: () {
                  context
                      .push('/customer-chat', extra: ticket)
                      .then((_) => _fetchTickets());
                },
              ),
            );
          }),
          MyTicketsEndIndicator(
            label: widget.staticData.endOfActiveTickets,
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: widgetColors.background,
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
          onRefresh: _fetchTickets,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                headerSection,
                const SizedBox(height: 16.0),
                filterSection,
                const SizedBox(height: 16.0),
                contentBody,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
