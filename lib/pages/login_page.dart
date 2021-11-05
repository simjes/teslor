import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase/supabase.dart';
import 'package:tosler/async_status.dart';
import 'package:tosler/components/auth_state.dart';
import 'package:tosler/utils/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static Route<dynamic> route() =>
      CupertinoPageRoute(builder: (context) => LoginPage());

  @override
  _LoginPageState createState() => _LoginPageState();
}

// TODO: customize
class _LoginPageState extends AuthState<LoginPage> {
  late final TextEditingController _emailController;
  AsyncStatus _loginStatus = AsyncStatus.notInitialized;
  var _errorMessage = '';

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
        _errorMessage = response.error?.message ?? 'Unable to log in';
      } else {
        _loginStatus = AsyncStatus.success;
        // context.showSnackBar(message: 'Check your email for login link!');
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
      child: SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          const Text('Sign in via the magic link with your email below'),
          const SizedBox(height: 18),
          CupertinoTextField(
            controller: _emailController,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            // decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 18),
          CupertinoButton(
            onPressed: _loginStatus == AsyncStatus.loading ? null : _signIn,
            child: Text(_loginStatus == AsyncStatus.loading
                ? 'Loading'
                : 'Send Magic Link'),
          ),
          SizedBox(
            height: 10,
          ),
          if (_loginStatus == AsyncStatus.loading)
            CupertinoActivityIndicator(
              animating: true,
            ),
          if (_loginStatus == AsyncStatus.error) Text(_errorMessage)
        ],
      )),
    );
  }
}
