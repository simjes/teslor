import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tosler/pages/home_page.dart';
import 'package:tosler/pages/login_page.dart';
import 'package:tosler/supabase_client.dart';
import 'package:tosler/teslor_list_tile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  var session = supabaseClient.auth.currentSession;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      home: session == null ? LoginPage() : const HomePage(),
    );
  }
}
