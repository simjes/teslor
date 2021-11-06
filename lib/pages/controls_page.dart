import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tosler/components/tosler_menu_button.dart';

class ControlsPage extends StatelessWidget {
  const ControlsPage({Key? key, required}) : super(key: key);
  static Route<dynamic> route() =>
      CupertinoPageRoute(builder: (context) => const ControlsPage());

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
                  Text("Open - frunk",
                      style: Theme.of(context).textTheme.headline6),
                  CupertinoButton(
                    child: const Icon(CupertinoIcons.lock_fill),
                    onPressed: () {},
                  ),
                  Row(
                    children: [
                      Text("Open - charger",
                          style: Theme.of(context).textTheme.headline6),
                      Text("Open - trunk",
                          style: Theme.of(context).textTheme.headline6),
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
