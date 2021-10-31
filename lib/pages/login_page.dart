import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tosler/async_status.dart';
import 'package:tosler/main.dart';
import 'package:tosler/pages/register_page.dart';
import 'package:tosler/supabase_client.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  static Route<dynamic> route() =>
      CupertinoPageRoute(builder: (context) => LoginPage());

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AsyncStatus _loginStatus = AsyncStatus.notInitialized;
  var _errorMessage = '';

  Future<void> onLogin() async {
    if (_usernameController.text == '' && _passwordController.text == '') {
      return;
    }

    setState(() {
      _loginStatus = AsyncStatus.loading;
    });

    var result = await supabaseClient.auth.signIn(
        email: _usernameController.text, password: _passwordController.text);

    setState(() {
      if (result.error != null) {
        _loginStatus = AsyncStatus.error;
        _errorMessage = result.error?.message ?? 'Unable to log in';
        return;
      }

      _loginStatus = AsyncStatus.success;

      Navigator.push(context, HomePage.route());
    });
  }

  void navigateToRegistration() {
    Navigator.push(context, RegisterPage.route());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0x7F00FF),
            Color(0xE100FFff),
          ],
        )),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoTextField(
                    controller: _usernameController,
                    placeholder: 'Username',
                    keyboardType: TextInputType.emailAddress,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                SizedBox(
                  height: 10,
                ),
                CupertinoTextField(
                    controller: _passwordController,
                    obscureText: true,
                    placeholder: 'Password',
                    padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                CupertinoButton(
                    child: Text('Don\'t have an account?'),
                    onPressed: navigateToRegistration),
                CupertinoButton.filled(
                    child: const Text("Sign in"), onPressed: onLogin),
                SizedBox(
                  height: 10,
                ),
                if (_loginStatus == AsyncStatus.loading)
                  CupertinoActivityIndicator(
                    animating: true,
                  ),
                if (_loginStatus == AsyncStatus.error) Text(_errorMessage)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
