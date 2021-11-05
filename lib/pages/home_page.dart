import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tosler/pages/account_page.dart';
import 'package:tosler/teslor_icons_icons.dart';

import '../teslor_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  static Route<dynamic> route() =>
      CupertinoPageRoute(builder: (context) => HomePage());
  final String title = "ble";

  @override
  State<HomePage> createState() => _HomePageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _HomePageState extends State<HomePage> {
  void _navigate() {
    Navigator.push(context, AccountPage.route());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Yondu",
                          style: TextStyle(fontSize: 20),
                        ),
                        Row(children: [
                          Icon(CupertinoIcons.battery_75_percent),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text("282km"),
                          ),
                        ]),
                        Text("Parked"),
                      ],
                    ),
                    CupertinoButton(
                      onPressed: _navigate,
                      child: Icon(CupertinoIcons.profile_circled),
                    ),
                  ],
                ),
              ),
              Image.asset("images/car.png"),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CupertinoButton(
                      onPressed: () {},
                      child: Icon(CupertinoIcons.lock),
                    ),
                    CupertinoButton(
                      onPressed: () {},
                      child: Icon(TeslorIcons.fan),
                    ),
                    CupertinoButton(
                      onPressed: () {},
                      child: Icon(CupertinoIcons.battery_charging),
                    ),
                    CupertinoButton(
                      onPressed: () {},
                      child: Icon(TeslorIcons.frunk),
                    )
                  ],
                ),
              ),
              // TODO: create list of controls
              TeslorListTile(
                title: "Controls",
                leading: CupertinoIcons.car,
                onTap: () {},
              ),
              TeslorListTile(
                title: "Climate",
                subtitle: "Interior 11C",
                leading: CupertinoIcons.waveform,
                onTap: () {},
              ),
              TeslorListTile(
                title: "Location",
                subtitle: "Noeveien 2",
                leading: CupertinoIcons.location_fill,
                onTap: () {},
              ),
              TeslorListTile(
                title: "Security",
                subtitle: "something",
                leading: CupertinoIcons.shield_fill,
                onTap: () {},
              ),
              TeslorListTile(
                title: "Upgrades",
                leading: CupertinoIcons.bag_fill,
                onTap: () {},
              ),
              TeslorListTile(
                title: "Service",
                leading: CupertinoIcons.wrench_fill,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
