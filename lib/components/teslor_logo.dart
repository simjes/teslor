import 'package:flutter/cupertino.dart';
import 'package:tosler/utils/constants.dart';
import 'package:tosler/utils/gradient_text.dart';

class TeslorLogo extends StatelessWidget {
  const TeslorLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GradientText(
      "Tosler",
      style: TextStyle(fontFamily: "Lazer84", fontSize: 60),
      gradient: LinearGradient(colors: [
        brightTurquoise,
        purplePizzazz,
      ]),
    );
  }
}
