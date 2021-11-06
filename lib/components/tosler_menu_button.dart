import 'package:flutter/cupertino.dart';
import 'package:tosler/utils/constants.dart';

class ToslerMenuButton extends StatelessWidget {
  ToslerMenuButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  String text;
  IconData icon;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: PurplePizzazz,
          ),
          Text(text, style: TextStyle(color: PurplePizzazz))
        ],
      ),
      onPressed: () {
        onPressed();
      },
    );
  }
}
