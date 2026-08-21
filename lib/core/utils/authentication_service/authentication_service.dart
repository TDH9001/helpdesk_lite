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
  }) async {
    final AuthResponse response = await SupabaseDeclaration.instance.auth
        .signUp(email: email, password: password);
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
