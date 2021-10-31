import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tosler/async_status.dart';
import 'package:tosler/main.dart';
import 'package:tosler/pages/login_page.dart';
import 'package:tosler/supabase_client.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static Route<dynamic> route() =>
      CupertinoPageRoute(builder: (context) => RegisterPage());

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AsyncStatus _registrationStatus = AsyncStatus.notInitialized;
  var _errorMessage = '';

  Future<void> onRegister() async {
    var registrationResponse = await supabaseClient.auth
        .signUp(_usernameController.text, _passwordController.text);

    if (registrationResponse.error != null) {
      return;
    }

    Navigator.push(context, HomePage.route());
  }

  void navigateToLogin() {
    Navigator.push(context, LoginPage.route());
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
                    child: Text('Already have an account?'),
                    onPressed: navigateToLogin),
                CupertinoButton.filled(
                    child: const Text("Register"), onPressed: onRegister)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
