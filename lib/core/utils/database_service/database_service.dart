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
}
