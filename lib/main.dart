import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tosler/pages/splash_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://arktzmtjqtjmefmmyeqi.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzNTcwNTg0NiwiZXhwIjoxOTUxMjgxODQ2fQ.Y6tsn1hJx16xZkdbOyss2HpWjoM8ZTPmX4U2M_5bpd0',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: const CupertinoApp(
        title: 'Tosler',
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
