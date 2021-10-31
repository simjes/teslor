import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tosler/async_status.dart';
import 'package:tosler/main.dart';
import 'package:tosler/pages/home_page.dart';
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
    setState(() {
      _registrationStatus = AsyncStatus.loading;
    });

    var response = await supabaseClient.auth
        .signUp(_usernameController.text, _passwordController.text);

    setState(() {
      if (response.error != null) {
        _registrationStatus = AsyncStatus.error;
        _errorMessage = response.error?.message ?? 'Unable to register';
        return;
      }

      _registrationStatus = AsyncStatus.success;

      Navigator.pushReplacement(context, HomePage.route());
    });
  }

  void navigateToLogin() {
    Navigator.pushReplacement(context, LoginPage.route());
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
          child: SingleChildScrollView(
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
                      child: const Text("Register"), onPressed: onRegister),
                  SizedBox(
                    height: 10,
                  ),
                  if (_registrationStatus == AsyncStatus.loading)
                    CupertinoActivityIndicator(
                      animating: true,
                    ),
                  if (_registrationStatus == AsyncStatus.error)
                    Text(_errorMessage)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
