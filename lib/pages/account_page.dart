import 'package:flutter/cupertino.dart';
import 'package:supabase/supabase.dart';
import 'package:tosler/async_status.dart';
import 'package:tosler/components/auth_required_state.dart';
import 'package:tosler/pages/login_page.dart';
import 'package:tosler/utils/constants.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);
  static Route<dynamic> route() =>
      CupertinoPageRoute(builder: (context) => AccountPage());

  @override
  _AccountPageState createState() => _AccountPageState();
}

// TODO: customize
class _AccountPageState extends AuthRequiredState<AccountPage> {
  final _usernameController = TextEditingController();
  final _websiteController = TextEditingController();

  AsyncStatus _submitStatus = AsyncStatus.notInitialized;

  /// Called once a user id is received within `onAuthenticated()`
  Future<void> _getProfile(String userId) async {
    // setState(() {
    //   _getProfileStatus = AsyncStatus.loading;
    // });

    // final response = await supabase
    //     .from('profiles')
    //     .select()
    //     .eq('id', userId)
    //     .single()
    //     .execute();
    // final error = response.error;

    // setState(() {
    //   if (error != null) {
    //     // _getProfileStatus = AsyncStatus.error;
    //     context.showDialog(
    //         title: "Error",
    //         message: response.error?.message ?? 'Unable to fetch profile');
    //   } else {
    //     final data = response.data;
    //     if (data != null) {
    //       _usernameController.text = (data['username'] ?? '') as String;
    //       _websiteController.text = (data['website'] ?? '') as String;
    //     }
    //     // _getProfileStatus = AsyncStatus.success;
    //   }
    // });
  }

  /// Called when user taps `Update` button
  Future<void> _updateProfile() async {
    setState(() {
      _submitStatus = AsyncStatus.loading;
    });
    final userName = _usernameController.text;
    final website = _websiteController.text;
    final user = supabase.auth.currentUser;
    final updates = {
      'id': user!.id,
      'username': userName,
      'website': website,
      'updated_at': DateTime.now().toIso8601String(),
    };
    final response = await supabase.from('profiles').upsert(updates).execute();
    final error = response.error;

    setState(() {
      if (error != null) {
        _submitStatus = AsyncStatus.error;
        context.showDialog(
            title: "Error",
            message: response.error?.message ?? 'Unable to update profile');
      } else {
        context.showDialog(
            title: "Success",
            message: response.error?.message ?? 'Unable to update profile');
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
  void onAuthenticated(Session session) {
    final user = session.user;
    if (user != null) {
      _getProfile(user.id);
    }
  }

  @override
  void onUnauthenticated() {
    Navigator.pushReplacement(context, LoginPage.route());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Account"),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          children: [
            CupertinoTextField(
              controller: _usernameController,
              placeholder: 'Username',
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              // decoration: const InputDecoration(labelText: 'User Name'),
            ),
            const SizedBox(height: 18),
            CupertinoTextField(
              controller: _websiteController,
              placeholder: 'Website',
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              // decoration: const InputDecoration(labelText: 'Website'),
            ),
            const SizedBox(height: 18),
            CupertinoButton(
                onPressed: _updateProfile,
                child: Text(_submitStatus == AsyncStatus.loading
                    ? 'Saving...'
                    : 'Update')),
            const SizedBox(height: 18),
            CupertinoButton(onPressed: _signOut, child: const Text('Sign Out')),
          ],
        ),
      ),
    );
  }
}
