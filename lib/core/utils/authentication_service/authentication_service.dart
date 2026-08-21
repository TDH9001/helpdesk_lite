import 'package:helpdesk_lite/core/utils/database_service/database_service.dart';
import 'package:helpdesk_lite/core/utils/shared_models/user_model.dart';
import 'package:helpdesk_lite/core/utils/supabase_service/Supabase_servic.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationService extends SupabaseDeclaration {
  User? getCurrentUser() {
    final user = SupabaseDeclaration.instance.auth.currentUser;
    return user;
  }

  Future<AuthResponse> signup({
    required String email,
    required String password,
    required UserType type,
    String? fullName,
  }) async {
    //logs in user, then adds user data to database
    final AuthResponse response = await SupabaseDeclaration.instance.auth
        .signUp(email: email, password: password);
    await DatabaseService().addNewUser(
      userModel: UserModel(
        id: response.user!.id,
        email: email,
        fullName: fullName,
        type: type,
        handledTickets: type == UserType.user ? null : 0,
      ),
    );
    return response;
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final AuthResponse response = await SupabaseDeclaration.instance.auth
        .signInWithPassword(email: email, password: password);
    return response;
  }

  Future<void> logout() async {
    final response = await SupabaseDeclaration.instance.auth.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    final response = await SupabaseDeclaration.instance.auth
        .resetPasswordForEmail(email);
  }
}
