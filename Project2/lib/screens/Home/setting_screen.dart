import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '/utils/user_shared_preferences.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late FirebaseAuth _auth;

  void iniFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
  }

  @override
  void initState() {
    super.initState();
    iniFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Text('Log out'),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Log Out"),
              content: Text('Are you sure you want to Log Out?'),
              actions: [
                TextButton(
                    onPressed: () {
                      _auth.signOut();
                      UserSharedPreference.deleteUser();
                      Get.toNamed('/login');
                    },
                    child: Text('Yes')),
                TextButton(
                    onPressed: () => Navigator.pop(context), child: Text('No')),
              ],
            ),
          );
        });
  }
}
