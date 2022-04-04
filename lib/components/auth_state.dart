import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tosler/pages/home_page.dart';
import 'package:tosler/pages/login_page.dart';
import 'package:tosler/utils/constants.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() {
    if (mounted) {
      Navigator.pushAndRemoveUntil(
          context, LoginPage.route(), (route) => false);
    }
  }

  @override
  void onAuthenticated(Session session) {
    if (mounted) {
      Navigator.pushAndRemoveUntil(context, HomePage.route(), (route) => false);
    }
  }

  @override
  void onPasswordRecovery(Session session) {}

  @override
  void onErrorAuthenticating(String message) {
    context.showDialog(title: "Authentication error", message: message);
  }
}
