import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return 

    GestureDetector(
                            child: Text('Log out'),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Log Out"),
                                  content:
                                      Text('Are you sure you want to Log Out?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          UserSharedPreference.deleteUser();
                                          UserSharedPreference
                                              .deleteFilterListNews();
                                          Get.toNamed('/login');
                                        },
                                        child: Text('Yes')),
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('No')),
                                  ],
                                ),
                              );
                            }
    );
  }
}
