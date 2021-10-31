import 'package:supabase/supabase.dart';

final supabaseClient = SupabaseClient(
  'https://arktzmtjqtjmefmmyeqi.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzNTcwNTg0NiwiZXhwIjoxOTUxMjgxODQ2fQ.Y6tsn1hJx16xZkdbOyss2HpWjoM8ZTPmX4U2M_5bpd0',
);

Future<void> getCarStatus() async {
  var user = supabaseClient.auth.currentUser;

  if (user == null) {
    // todo: route to login
    return;
  }

  var response = await supabaseClient
      .from('car')
      .select()
      .eq('owner_id', user.id)
      .execute();
}
