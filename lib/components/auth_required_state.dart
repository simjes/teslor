import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tosler/pages/login_page.dart';

class AuthRequiredState<T extends StatefulWidget>
    extends SupabaseAuthRequiredState<T> {
  @override
  void onUnauthenticated() {
    /// Users will be sent back to the LoginPage if they sign out.
    Navigator.pushAndRemoveUntil(context, LoginPage.route(), (route) => false);
  }
}
