import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tosler/components/auth_state.dart';
import 'package:tosler/components/teslor_logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends AuthState<SplashPage> {
  @override
  void initState() {
    recoverSupabaseSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            TeslorLogo(),
            SizedBox(
              height: 20,
            ),
            CupertinoActivityIndicator(
              animating: true,
            ),
          ],
        ),
      ),
    );
  }
}
