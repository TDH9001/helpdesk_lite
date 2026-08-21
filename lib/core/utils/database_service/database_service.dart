import 'dart:developer' as dev show log;

import 'package:helpdesk_lite/core/utils/database_service/database_endpoints.dart';
import 'package:helpdesk_lite/core/utils/shared_models/user_model.dart';
import 'package:helpdesk_lite/core/utils/supabase_service/Supabase_servic.dart';

class DatabaseService extends SupabaseDeclaration {
  Future<void> addNewUser({required UserModel userModel}) async {
    final result = await SupabaseDeclaration.instance
        .from(DatabaseEndpoints.userTable)
        .insert(userModel.toJson());
    return result;
  }

  Future<UserModel> getUserData({required String userId}) async {
    final result = await SupabaseDeclaration.instance
        .from(DatabaseEndpoints.userTable)
        .select()
        .eq('id', userId)
        .single();
    return UserModel.fromJson(result);
  }

  Future<void> incrementHandledTickets({required String userId}) async {
    final user = await getUserData(userId: userId);
    final currentCount = user.handledTickets ?? 0;
    await SupabaseDeclaration.instance
        .from(DatabaseEndpoints.userTable)
        .update({'handled_tickets': currentCount + 1})
        .eq('id', userId);
  }

  Future<List<UserModel>> getAgents() async {
    final result = await SupabaseDeclaration.instance
        .from(DatabaseEndpoints.userTable)
        .select()
        .eq('type', UserType.worker.toInt())
        .order('handled_tickets', ascending: false);
    dev.log(result.toString());
    return (result as List).map((e) => UserModel.fromJson(e)).toList();
  }
}
