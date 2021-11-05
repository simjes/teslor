import 'package:flutter/cupertino.dart';
import 'package:tosler/utils/constants.dart';
import 'package:tosler/utils/gradient_text.dart';

class TeslorLogo extends StatelessWidget {
  const TeslorLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientText(
      "Tosler",
      style: const TextStyle(fontFamily: "Lazer84", fontSize: 80),
      gradient: LinearGradient(colors: [
        BrightTurquoise,
        PurplePizzazz,
      ]),
    );
  }
}
