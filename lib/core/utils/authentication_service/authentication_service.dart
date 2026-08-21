import 'package:helpdesk_lite/core/utils/supabase_service/Supabase_servic.dart';

class AuthenticationService extends SupabaseDeclaration {
  Future<void> signup({required String email, required String password}) async {
    final response = await SupabaseDeclaration.instance.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<void> login({required String email, required String password}) async {
    final response = await SupabaseDeclaration.instance.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    final response = await SupabaseDeclaration.instance.auth.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    final response = await SupabaseDeclaration.instance.auth
        .resetPasswordForEmail(email);
  }
}
