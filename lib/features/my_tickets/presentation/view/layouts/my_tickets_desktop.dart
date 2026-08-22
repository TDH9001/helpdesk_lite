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
import 'package:helpdesk_lite/features/my_tickets/presentation/view/widgets/my_tickets_header_desktop.dart';
import 'package:helpdesk_lite/features/my_tickets/presentation/view/widgets/my_tickets_search_bar.dart';
import 'package:helpdesk_lite/features/my_tickets/presentation/view/widgets/ticket_table_row_desktop.dart';

/// Desktop layout representation of the My Tickets screen with data table.
class MyTicketsDesktop extends StatefulWidget {
  final MyTicketsStaticModel staticData;

  const MyTicketsDesktop({
    super.key,
    required this.staticData,
  });

  @override
  State<MyTicketsDesktop> createState() => _MyTicketsDesktopState();
}

class _MyTicketsDesktopState extends State<MyTicketsDesktop> {
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

    // Page title and subtitle section
    final titleSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.staticData.myTicketsTitle,
          style: AppFonts().desktopMyTicketsTitleInter30SemiBold(
            context,
            color: widgetColors.onBackground,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          widget.staticData.manageAssignedIssues,
          style: AppFonts().desktopMyTicketsSubtitleInter13Regular(
            context,
            color: widgetColors.onSurfaceVariant,
          ),
        ),
      ],
    );

    // Search bar and group selectors next to it
    final searchAndFilterRow = Row(
      children: [
        Expanded(
          flex: 4,
          child: MyTicketsSearchBar(
            placeholder: widget.staticData.searchDesktopPlaceholder,
            isDesktop: true,
            onChanged: (query) => setState(() => _searchQuery = query),
          ),
        ),
        const SizedBox(width: 16.0),
        MyTicketsFilterChips(
          allActiveLabel: widget.staticData.filterAllActive,
          openLabel: widget.staticData.filterOpen,
          pendingLabel: widget.staticData.filterPending,
          waitingLabel: widget.staticData.filterWaiting,
          selectedStatus: _selectedStatus,
          isDesktop: true,
          onStatusSelected: (status) =>
              setState(() => _selectedStatus = status),
        ),
      ],
    );

    // High density data table container
    final dataTableSection = Container(
      decoration: BoxDecoration(
        color: widgetColors.surface,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: widgetColors.outlineVariant.withValues(alpha: 0.5),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Table column headers row
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: widgetColors.surfaceContainerLow,
              border: Border(
                bottom: BorderSide(
                  color: widgetColors.outlineVariant.withValues(alpha: 0.5),
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    widget.staticData.tableHeaderId.toUpperCase(),
                    style: AppFonts()
                        .desktopMyTicketsTableHeaderInter11SemiBold(
                      context,
                      color: widgetColors.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  flex: 5,
                  child: Text(
                    widget.staticData.tableHeaderSubject.toUpperCase(),
                    style: AppFonts()
                        .desktopMyTicketsTableHeaderInter11SemiBold(
                      context,
                      color: widgetColors.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  flex: 2,
                  child: Text(
                    widget.staticData.tableHeaderStatus.toUpperCase(),
                    style: AppFonts()
                        .desktopMyTicketsTableHeaderInter11SemiBold(
                      context,
                      color: widgetColors.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      widget.staticData.tableHeaderPriority.toUpperCase(),
                      style: AppFonts()
                          .desktopMyTicketsTableHeaderInter11SemiBold(
                        context,
                        color: widgetColors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.staticData.tableHeaderUpdated.toUpperCase(),
                      style: AppFonts()
                          .desktopMyTicketsTableHeaderInter11SemiBold(
                        context,
                        color: widgetColors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Table ticket rows or loading / empty state
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(40.0),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_filteredTickets.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Center(
                child: Text(
                  'No tickets found',
                  style: AppFonts().desktopMyTicketsSubtitleInter13Regular(
                    context,
                    color: widgetColors.onSurfaceVariant,
                  ),
                ),
              ),
            )
          else
            ..._filteredTickets.map((ticket) {
              return TicketTableRowDesktop(
                ticket: ticket,
                statusLabel: _getStatusLabel(ticket.status),
                priorityLabel: _getPriorityLabel(ticket.priority),
                onTap: () {
                  context
                      .push('/customer-chat', extra: ticket)
                      .then((_) => _fetchTickets());
                },
              );
            }),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: widgetColors.background,
      body: Column(
        children: [
          // Top App Header
          const MyTicketsHeaderDesktop(),
          // Scrollable Page Content
          Expanded(
            child: RefreshIndicator(
              onRefresh: _fetchTickets,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 24.0,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        titleSection,
                        const SizedBox(height: 16.0),
                        searchAndFilterRow,
                        const SizedBox(height: 24.0),
                        dataTableSection,
                        MyTicketsEndIndicator(
                          label: widget.staticData.endOfActiveTickets,
                          isDesktop: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
