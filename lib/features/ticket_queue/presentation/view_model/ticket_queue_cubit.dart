import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/database_service/database_service.dart';
import 'package:helpdesk_lite/core/utils/local_storage_service/user_hive_box.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_model.dart';
import 'package:helpdesk_lite/core/utils/shared_models/user_model.dart';
import 'package:helpdesk_lite/core/utils/snackbar_service/snackbar_service.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view/widgets/ticket_queue_filter_chips_widget.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view_model/ticket_queue_states.dart';

/// Cubit managing ticket queue data fetching, filtering, search, and assignments.
class TicketQueueCubit extends Cubit<TicketQueueStates> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController searchController = TextEditingController();

  TicketQueueCubit() : super(TicketQueueInitial());

  List<TicketModel> tickets = [];
  QueueFilterType selectedFilter = QueueFilterType.allActive;
  UserModel? currentUser;

  /// Loads current user session and fetches queue tickets.
  Future<void> init() async {
    currentUser = await UserHiveBox.getUserData();
    await fetchTickets();
  }

  /// Fetches queue tickets matching current filter and search criteria.
  Future<void> fetchTickets() async {
    emit(TicketQueueLoading());
    try {
      tickets = await _databaseService.getQueueTickets(
        unassignedOnly: selectedFilter == QueueFilterType.unassigned,
        highPriorityOnly: selectedFilter == QueueFilterType.highPriority,
        searchQuery: searchController.text,
      );
      emit(TicketQueueSuccess());
    } catch (e) {
      emit(TicketQueueFailure());
    }
  }

  /// Updates current search query and triggers fetch.
  void setSearchQuery(String query) {
    fetchTickets();
  }

  /// Clears the search text and refreshes tickets.
  void clearSearch() {
    searchController.clear();
    fetchTickets();
  }

  /// Updates active filter chip and triggers fetch.
  void setFilter(QueueFilterType filter) {
    selectedFilter = filter;
    fetchTickets();
  }

  /// Assigns a ticket to the current agent and updates local state.
  Future<void> assignTicketToMe({
    required BuildContext context,
    required TicketModel ticket,
    required String successMessage,
  }) async {
    if (currentUser == null) return;
    try {
      final updated = await _databaseService.assignTicketToAgent(
        ticketId: ticket.id,
        agentId: currentUser!.id,
        agentName: currentUser!.fullName ?? currentUser!.email.split('@')[0],
      );
      tickets = tickets.map((t) => t.id == updated.id ? updated : t).toList();
      emit(TicketQueueSuccess());
      if (context.mounted) {
        SnackBarService.showInfo(context, successMessage);
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarService.showError(context, e.toString());
      }
    }
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
