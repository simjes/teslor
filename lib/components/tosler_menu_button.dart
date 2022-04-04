import 'package:flutter/cupertino.dart';
import 'package:tosler/utils/constants.dart';

class ToslerMenuButton extends StatelessWidget {
  const ToslerMenuButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: purplePizzazz,
          ),
          Text(text, style: const TextStyle(color: purplePizzazz))
        ],
      ),
      onPressed: () {
        onPressed();
      },
    );
  }
}
