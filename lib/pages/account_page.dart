import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tosler/async_status.dart';
import 'package:tosler/components/auth_required_state.dart';
import 'package:tosler/models/car_settings.dart';
import 'package:tosler/pages/login_page.dart';
import 'package:tosler/utils/constants.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key, required this.carSettings}) : super(key: key);
  static Route<dynamic> route(CarSettings carSettings) => CupertinoPageRoute(
      builder: (context) => AccountPage(carSettings: carSettings));

  final CarSettings carSettings;

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends AuthRequiredState<AccountPage> {
  final _carNameController = TextEditingController();

  AsyncStatus _submitStatus = AsyncStatus.notInitialized;

  /// Called when user taps `Update` button
  Future<void> _updateProfile() async {
    setState(() {
      _submitStatus = AsyncStatus.loading;
    });
    final carName = _carNameController.text;
    final user = supabase.auth.currentUser;

    final response = await supabase.from('car').update({"name": carName})
        // TODO user!.id
        .match({"owner_id": 'c0965996-8467-4a63-9584-725b3d068aba'}).execute();
    final error = response.error;

    setState(() {
      if (error != null) {
        _submitStatus = AsyncStatus.error;
        context.showDialog(
            title: "Error",
            message:
                response.error?.message ?? 'Unable to update car settings');
      } else {
        context.showDialog(
            title: "Success",
            message: response.error?.message ?? 'Car settings updated');
        _submitStatus = AsyncStatus.success;
      }
    });
  }

  Future<void> _signOut() async {
    final response = await supabase.auth.signOut();
    final error = response.error;
    if (error != null) {
      context.showDialog(
          title: "Error",
          message: response.error?.message ?? 'Unable to sign out');
    }
    Navigator.pushAndRemoveUntil(context, LoginPage.route(), (route) => false);
  }

  @override
  void onUnauthenticated() {
    Navigator.pushReplacement(context, LoginPage.route());
  }

  @override
  void initState() {
    super.initState();
    _carNameController.text = widget.carSettings.name;
  }

  @override
  void dispose() {
    _carNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textColor =
        CupertinoDynamicColor.resolve(CupertinoColors.label, context);

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Account"),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          children: [
            Text('Car name',
                style: Theme.of(context)
                    .textTheme
                    .overline!
                    .copyWith(color: textColor)),
            CupertinoTextField(
              controller: _carNameController,
              placeholder: 'Car name',
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            const SizedBox(height: 18),
            CupertinoButton(
                onPressed: _updateProfile,
                child: Text(_submitStatus == AsyncStatus.loading
                    ? 'Saving...'
                    : 'Update')),
            const SizedBox(height: 18),
            CupertinoButton(
                onPressed: _signOut,
                child: Text('Sign Out',
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Colors.red))),
          ],
        ),
      ),
    );
  }
}
