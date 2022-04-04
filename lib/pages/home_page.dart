import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:supabase/supabase.dart';
import 'package:tosler/async_status.dart';
import 'package:tosler/components/auth_required_state.dart';
import 'package:tosler/components/car_summary.dart';
import 'package:tosler/models/car.dart';
import 'package:tosler/models/car_settings.dart';
import 'package:tosler/pages/account_page.dart';
import 'package:tosler/pages/controls_page.dart';
import 'package:tosler/pages/location_page.dart';
import 'package:tosler/pages/login_page.dart';
import 'package:tosler/teslor_icons_icons.dart';
import 'package:tosler/teslor_list_tile.dart';
import 'package:tosler/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  static Route<dynamic> route() =>
      CupertinoPageRoute(builder: (context) => const HomePage());

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends AuthRequiredState<HomePage> {
  var _getCarStatus = AsyncStatus.loading;
  Car car = Car();
  late RealtimeSubscription carSubscription;

  Artboard? _riveArtboard;
  StateMachineController? _riveController;
  SMIInput<bool>? _driveInTrigger;
  SMIInput<bool>? _chargingTrigger;
  SMIInput<bool>? _frunkTrigger;

  @override
  void initState() {
    super.initState();

    rootBundle.load('animations/delorean_animation.riv').then((data) async {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;

      var controller = StateMachineController.fromArtboard(
        artboard,
        'Driving',
      );

      if (controller != null) {
        artboard.addController(controller);
        _driveInTrigger = controller.findInput('driveIn');
        _driveInTrigger!.value = true;

        _chargingTrigger = controller.findInput('charging');
        _chargingTrigger!.value = false;

        _frunkTrigger = controller.findInput('frunk');
        _frunkTrigger!.value = false;
      }

      setState(() => _riveArtboard = artboard);
    });
  }

  Future<void> _getCar(String userId) async {
    setState(() {
      _getCarStatus = AsyncStatus.loading;
    });

    final response = await supabase
        .from('car')
        .select()
        .eq('owner_id', userId)
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

          _chargingTrigger!.value = car.charging;
          _frunkTrigger!.value = car.openFrunk;
        }

        // TODO: set after driveIn is done?
        _getCarStatus = AsyncStatus.success;
      }
    });
  }

  Future<void> _updateSetting(String key, dynamic value) async {
    final user = supabase.auth.currentUser;
    await supabase
        .from('car')
        .update({key: value}).match({"owner_id": user!.id}).execute();
  }

  void _navigate() {
    var carSettings = CarSettings(name: car.name ?? '');
    Navigator.push(context, AccountPage.route(carSettings));
  }

  @override
  void onAuthenticated(Session session) {
    final user = session.user;
    if (user != null) {
      _getCar(user.id);
      _setupCarSubscription(user.id);
    }
  }

  @override
  void onUnauthenticated() {
    Navigator.pushReplacement(context, LoginPage.route());
  }

  @override
  void dispose() {
    supabase.removeSubscription(carSubscription);
    if (_riveController != null) {
      _riveController!.dispose();
    }
    super.dispose();
  }

  void _setupCarSubscription(String userId) {
    carSubscription = supabase
        .from('car:owner_id=eq.$userId')
        .on(SupabaseEventTypes.update, (payload) {
      setState(() {
        if (payload.newRecord != null) {
          car = Car.fromJson(payload.newRecord!);
          _chargingTrigger!.value = car.charging;
          _frunkTrigger!.value = car.openFrunk;
        }
      });
    }).subscribe();
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
                      child: const Icon(
                        CupertinoIcons.profile_circled,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
                child: _riveArtboard != null
                    ? Rive(
                        artboard: _riveArtboard!,
                        fit: BoxFit.fitHeight,
                      )
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CupertinoButton(
                      onPressed: () {
                        _updateSetting("open_car", !car.openCar);
                      },
                      child: Icon(
                        car.openCar
                            ? CupertinoIcons.lock_open_fill
                            : CupertinoIcons.lock_fill,
                        color: car.openCar ? brightTurquoise : Colors.grey,
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        // Not implemented - missing in database
                      },
                      child: const Icon(
                        TeslorIcons.fan,
                        color: Colors.grey,
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        _updateSetting("charging", !car.charging);
                      },
                      child: Icon(
                        car.charging
                            ? CupertinoIcons.bolt_circle_fill
                            : CupertinoIcons.bolt_slash_fill,
                        color: car.charging ? brightTurquoise : Colors.grey,
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        _updateSetting("open_frunk", !car.openFrunk);
                      },
                      child: Icon(
                        TeslorIcons.frunk,
                        color: car.openFrunk ? brightTurquoise : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              TeslorListTile(
                title: "Controls",
                leading: CupertinoIcons.car_detailed,
                onTap: () {
                  Navigator.push(context, ControlsPage.route());
                },
              ),
              TeslorListTile(
                title: "Climate",
                subtitle: "Interior ${car.interiorDegrees}°C",
                leading: CupertinoIcons.waveform,
                onTap: () {},
              ),
              TeslorListTile(
                title: "Location",
                leading: CupertinoIcons.location_fill,
                onTap: () {
                  Navigator.push(
                      context,
                      LocationPage.route(
                          car.latitude ?? 0, car.longitude ?? 0));
                },
              ),
              TeslorListTile(
                title: "Security",
                subtitle: "Connected",
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
