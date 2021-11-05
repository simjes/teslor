import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:supabase/supabase.dart';
import 'package:tosler/async_status.dart';
import 'package:tosler/components/auth_required_state.dart';
import 'package:tosler/components/car_summary.dart';
import 'package:tosler/models/car.dart';
import 'package:tosler/pages/account_page.dart';
import 'package:tosler/pages/login_page.dart';
import 'package:tosler/teslor_icons_icons.dart';
import 'package:tosler/teslor_list_tile.dart';
import 'package:tosler/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  static Route<dynamic> route() =>
      CupertinoPageRoute(builder: (context) => HomePage());

  @override
  _HomePageState createState() => _HomePageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _HomePageState extends AuthRequiredState<HomePage> {
  var _getCarStatus = AsyncStatus.loading;
  late Car car;

  Future<void> _getCar(String userId) async {
    setState(() {
      _getCarStatus = AsyncStatus.loading;
    });

    final response = await supabase
        .from('car')
        .select()
        // TODO:
        .eq('owner_id', 'c0965996-8467-4a63-9584-725b3d068aba')
        // .eq('id', userId)
        .single()
        .execute();
    final error = response.error;

    setState(() {
      if (error != null) {
        _getCarStatus = AsyncStatus.error;
        context.showDialog(
            title: "Error",
            message: response.error?.message ?? 'Unable to fetch car info');
      } else {
        final data = response.data;
        if (data != null) {
          car = Car.fromJson(data);
        }
        _getCarStatus = AsyncStatus.success;
      }
    });
  }

  void _navigate() {
    Navigator.push(context, AccountPage.route());
  }

  @override
  void onAuthenticated(Session session) {
    final user = session.user;
    if (user != null) {
      _getCar(user.id);
    }
  }

  @override
  void onUnauthenticated() {
    Navigator.pushReplacement(context, LoginPage.route());
  }

  @override
  void dispose() {
    super.dispose();
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
                    CarSummary(
                      name: car.name,
                      range: car.battery,
                      parked: car.parked,
                    ),
                    CupertinoButton(
                      onPressed: _navigate,
                      child: Icon(
                        CupertinoIcons.profile_circled,
                        color: Colors.grey,
                      ),
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
                      child: Icon(
                        car.openCar
                            ? CupertinoIcons.lock_open_fill
                            : CupertinoIcons.lock_fill,
                        color: Colors.grey,
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {},
                      child: Icon(
                        TeslorIcons.fan,
                        color: Colors.grey,
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {},
                      child: Icon(
                        CupertinoIcons.battery_charging,
                        color: Colors.grey,
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {},
                      child: Icon(
                        TeslorIcons.frunk,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              // TODO: create list of controls
              TeslorListTile(
                title: "Controls",
                leading: CupertinoIcons.car,
                onTap: () {},
                isLoading: _getCarStatus == AsyncStatus.loading,
              ),
              TeslorListTile(
                title: "Climate",
                subtitle: "Interior ${car.interiorDegrees}°C",
                leading: CupertinoIcons.waveform,
                onTap: () {},
                isLoading: _getCarStatus == AsyncStatus.loading,
              ),
              TeslorListTile(
                title: "Location",
                // TODO:
                subtitle: "Noeveien 2",
                leading: CupertinoIcons.location_fill,
                onTap: () {},
                isLoading: _getCarStatus == AsyncStatus.loading,
              ),
              TeslorListTile(
                title: "Security",
                // TODO:
                subtitle: "Connected",
                leading: CupertinoIcons.shield_fill,
                onTap: () {},
                isLoading: _getCarStatus == AsyncStatus.loading,
              ),
              TeslorListTile(
                title: "Upgrades",
                leading: CupertinoIcons.bag_fill,
                onTap: () {},
                isLoading: _getCarStatus == AsyncStatus.loading,
              ),
              TeslorListTile(
                title: "Service",
                leading: CupertinoIcons.wrench_fill,
                onTap: () {},
                isLoading: _getCarStatus == AsyncStatus.loading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
