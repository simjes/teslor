import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

// colors
const brightTurquoise = Color(0xFF00C3FF);
const purplePizzazz = Color(0xFFFF00CC);

// sizes - TODO

extension ShowDialog on BuildContext {
  void showDialog({required String title, required String message}) {
    showCupertinoDialog<void>(
      context: this,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
