import 'package:flutter/cupertino.dart';
import 'package:tosler/components/auth_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

// TODO: add logo or image
class _SplashPageState extends AuthState<SplashPage> {
  @override
  void initState() {
    recoverSupabaseSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: CupertinoActivityIndicator(
          animating: true,
        ),
      ),
    );
  }
}
