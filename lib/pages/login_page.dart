import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:tosler/async_status.dart';
import 'package:tosler/components/auth_state.dart';
import 'package:tosler/components/teslor_logo.dart';
import 'package:tosler/utils/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static Route<dynamic> route() =>
      CupertinoPageRoute(builder: (context) => const LoginPage());

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends AuthState<LoginPage> {
  late final TextEditingController _emailController;
  AsyncStatus _loginStatus = AsyncStatus.notInitialized;

  Future<void> _signIn() async {
    setState(() {
      _loginStatus = AsyncStatus.loading;
    });
    final response = await supabase.auth.signIn(
        email: _emailController.text,
        options: AuthOptions(
            redirectTo:
                kIsWeb ? null : 'io.supabase.tosler://login-callback/'));
    final error = response.error;

    setState(() {
      if (error != null) {
        _loginStatus = AsyncStatus.error;
        context.showDialog(
            title: "Error",
            message: response.error?.message ?? 'Unable to log in');
      } else {
        _loginStatus = AsyncStatus.success;

        context.showDialog(
            title: "Success", message: 'Check your email for login link!');
        _emailController.clear();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.black,
      child: Container(
        padding: const EdgeInsets.all(40.0),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TeslorLogo(),
            const SizedBox(height: 40),
            CupertinoTextField(
                controller: _emailController,
                placeholder: 'Email',
                keyboardType: TextInputType.emailAddress,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            const SizedBox(height: 18),
            CupertinoButton(
              onPressed: _loginStatus == AsyncStatus.loading ? null : _signIn,
              child: Text(_loginStatus == AsyncStatus.loading
                  ? 'Loading'
                  : 'Send Magic Link'),
            ),
          ],
        )),
      ),
    );
  }
}
