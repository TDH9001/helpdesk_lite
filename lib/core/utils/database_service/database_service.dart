import 'dart:developer' as dev show log;

import 'package:helpdesk_lite/core/utils/database_service/database_endpoints.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_model.dart';
import 'package:helpdesk_lite/core/utils/shared_models/user_model.dart';
import 'package:helpdesk_lite/core/utils/supabase_service/Supabase_servic.dart';

class DatabaseService extends SupabaseDeclaration {
  /// Adds a new user profile record to the database.
  Future<void> addNewUser({required UserModel userModel}) async {
    final result = await SupabaseDeclaration.instance
        .from(DatabaseEndpoints.userTable)
        .insert(userModel.toJson());
    return result;
  }

  /// Retrieves user profile details by their user identifier.
  Future<UserModel> getUserData({required String userId}) async {
    final result = await SupabaseDeclaration.instance
        .from(DatabaseEndpoints.userTable)
        .select()
        .eq('id', userId)
        .single();
    return UserModel.fromJson(result);
  }

  /// Increments the total tickets handled counter for a worker.
  Future<void> incrementHandledTickets({required String userId}) async {
    final user = await getUserData(userId: userId);
    final currentCount = user.handledTickets ?? 0;
    await SupabaseDeclaration.instance
        .from(DatabaseEndpoints.userTable)
        .update({'handled_tickets': currentCount + 1}).eq('id', userId);
  }

  /// Fetches a list of all active support agents sorted by handled ticket count.
  Future<List<UserModel>> getAgents() async {
    final result = await SupabaseDeclaration.instance
        .from(DatabaseEndpoints.userTable)
        .select()
        .eq('type', UserType.worker.toInt())
        .order('handled_tickets', ascending: false);
    dev.log(result.toString());
    return (result as List).map((e) => UserModel.fromJson(e)).toList();
  }

  /// Adds a ticket identifier to a user's ticket_ids array.
  Future<void> addTicketToUser({
    required String userId,
    required String ticketId,
  }) async {
    final user = await getUserData(userId: userId);
    final currentTicketIds = List<String>.from(user.ticketIds);
    if (!currentTicketIds.contains(ticketId)) {
      currentTicketIds.add(ticketId);
      await SupabaseDeclaration.instance
          .from(DatabaseEndpoints.userTable)
          .update({'ticket_ids': currentTicketIds}).eq('id', userId);
    }
  }

  /// Creates a new support ticket and links it to the creator's profile.
  Future<TicketModel> createTicket({required TicketModel ticket}) async {
    final payload = ticket.toJson();
    if (ticket.id.isEmpty) {
      payload.remove('id');
    }
    if (ticket.code.trim().isEmpty) {
      payload.remove('code');
    }
    final result = await SupabaseDeclaration.instance
        .from(DatabaseEndpoints.ticketTable)
        .insert(payload)
        .select()
        .single();

    final createdTicket = TicketModel.fromJson(result);

    if (createdTicket.creatorId != null &&
        createdTicket.creatorId!.trim().isNotEmpty) {
      try {
        await addTicketToUser(
          userId: createdTicket.creatorId!,
          ticketId: createdTicket.id,
        );
      } catch (e) {
        dev.log('Could not append ticket ID to user ticket_ids list: $e');
      }
    }

    return createdTicket;
  }

  /// Retrieves tickets created by a specific user.
  Future<List<TicketModel>> getMyTickets({
    required String userId,
  }) async {
    final result = await SupabaseDeclaration.instance
        .from(DatabaseEndpoints.ticketTable)
        .select()
        .eq('is_deleted', false)
        .eq('creator_id', userId)
        .order('updated_at', ascending: false);

    return (result as List).map((e) => TicketModel.fromJson(e)).toList();
  }

  /// Retrieves all tickets in the queue matching optional filter parameters.
  Future<List<TicketModel>> getQueueTickets({
    bool unassignedOnly = false,
    bool highPriorityOnly = false,
    String searchQuery = '',
  }) async {
    var query = SupabaseDeclaration.instance
        .from(DatabaseEndpoints.ticketTable)
        .select()
        .eq('is_deleted', false);

    if (unassignedOnly) {
      query = query.isFilter('assignee_id', null);
    }
    if (highPriorityOnly) {
      // Urgent (0) or High (1)
      query = query.inFilter('priority', [0, 1]);
    }

    final result = await query.order('created_at', ascending: false);
    final list = (result as List).map((e) => TicketModel.fromJson(e)).toList();

    if (searchQuery.trim().isEmpty) {
      return list;
    }
//? genuinly don't understand but im abd at supabase at the moment
    final lower = searchQuery.toLowerCase().trim();
    return list.where((t) {
      final codeMatches = t.code.toLowerCase().contains(lower);
      final titleMatches = t.title.toLowerCase().contains(lower);
      final customerMatches =
          (t.creatorName ?? '').toLowerCase().contains(lower);
      final categoryMatches =
          (t.category ?? '').toLowerCase().contains(lower);
      return codeMatches ||
          titleMatches ||
          customerMatches ||
          categoryMatches;
    }).toList();
  }

  /// Assigns an open or unassigned ticket to a specific agent and updates counters.
  Future<TicketModel> assignTicketToAgent({
    required String ticketId,
    required String agentId,
    required String agentName,
    TicketPriority? priority,
  }) async {
    final updatePayload = {
      'assignee_id': agentId,
      'assignee_name': agentName,
      'status': TicketStatus.pending.toInt(),
      if (priority != null) 'priority': priority.toInt(),
      'updated_at': DateTime.now().toIso8601String(),
    };

    final result = await SupabaseDeclaration.instance
        .from(DatabaseEndpoints.ticketTable)
        .update(updatePayload)
        .eq('id', ticketId)
        .select()
        .single();
    //this shold be added in the ticket ahndlign section
    // try {
    //   await incrementHandledTickets(userId: agentId);
    // } catch (e) {
    //   dev.log('Could not increment agent handled tickets count: $e');
    // }

    return TicketModel.fromJson(result);
  }

  /// Updates the lifecycle status of a ticket.
  Future<void> updateTicketStatus({
    required String ticketId,
    required TicketStatus status,
  }) async {
    await SupabaseDeclaration.instance
        .from(DatabaseEndpoints.ticketTable)
        .update({
          'status': status.toInt(),
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', ticketId);
  }

  /// Allows a handling agent to adjust a ticket's priority level.
  Future<void> updateTicketPriority({
    required String ticketId,
    required TicketPriority priority,
  }) async {
    await SupabaseDeclaration.instance
        .from(DatabaseEndpoints.ticketTable)
        .update({
          'priority': priority.toInt(),
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', ticketId);
  }
}
