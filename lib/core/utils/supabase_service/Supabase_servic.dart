import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseDeclaration {
  static Future<void> initSupabase() async {
    await Supabase.initialize(
      url: 'https://uuoqwovbmdnukfaqkucc.supabase.co',
      publishableKey: 'sb_publishable__N4w9yF4csosA0s3TsMVMA_3ZfDPiz8',
    );
  }

  static SupabaseClient instance = Supabase.instance.client;
}
