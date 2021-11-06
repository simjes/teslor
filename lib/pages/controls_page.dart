import 'package:flutter/cupertino.dart';
import 'package:tosler/components/tosler_menu_button.dart';
import 'package:tosler/utils/constants.dart';

class ControlsPage extends StatelessWidget {
  ControlsPage({Key? key, required}) : super(key: key);
  static Route<dynamic> route() =>
      CupertinoPageRoute(builder: (context) => ControlsPage());

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Controls"),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Open - frunk",
                  ),
                  CupertinoButton(
                    child: Icon(CupertinoIcons.lock_fill),
                    onPressed: () {},
                  ),
                  Row(
                    children: [
                      Text("Open - charger"),
                      Text("Open - trunk"),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ToslerMenuButton(
                  text: "Flash",
                  icon: CupertinoIcons.lightbulb_fill,
                  onPressed: () {},
                ),
                ToslerMenuButton(
                  text: "Honk",
                  icon: CupertinoIcons.volume_up,
                  onPressed: () {},
                ),
                ToslerMenuButton(
                  text: "Start",
                  icon: CupertinoIcons.car_detailed,
                  onPressed: () {},
                ),
                ToslerMenuButton(
                  text: "Vent",
                  icon: CupertinoIcons.wind,
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
