import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseDeclaration {
  static Future<void> initSupabase() async {
    await Supabase.initialize(
      url: 'https://kiuzkdhrboswdwcyiqbu.supabase.co',
      publishableKey: 'sb_publishable_AmVpCd4_5tKub4r3JD9jqA_-GB6tmN-',
    );
  }

  static SupabaseClient instance = Supabase.instance.client;
}
