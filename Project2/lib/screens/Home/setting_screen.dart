import 'package:flutter/material.dart';
import 'package:travelling_app/screens/Home/editProfile.dart';
import '/utils/user_shared_preferences.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '/screens/Home/editProfile.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>  with SingleTickerProviderStateMixin{
  late FirebaseAuth _auth;
  late TabController _tabController;

  void iniFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
  }

  @override
  void initState() {
    super.initState();
    iniFirebase();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(onTap);
  }

  List<bool> _isDisabled = [false, true];
  onTap() {
    if (_isDisabled[_tabController.index]) {
      int index = _tabController.previousIndex;
      setState(() {
        _tabController.index = index;
      });
    }
    @override
    void dispose() {
      _tabController.dispose();
      super.dispose();
    }
  }



 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        iconSize: 30.0,
                      ),
                      Padding(
                        padding:  EdgeInsets.fromLTRB(85,0,0,0),
                        child: IconButton(
                          icon: Icon(
                            Icons.account_circle_rounded,
                            size: 80,
                            color: Colors.grey[800],
                          ),
                          onPressed: () {},
                        ),
                      ),
              ],
            ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 9, 0.0),
              child: Text(
                UserSharedPreference.getUser()[1],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 10, 0.0, 0.0),
              child: Text(
                UserSharedPreference.getUser()[2],
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.00, 20, 0.0, 0.0),
              child: Container(
                child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    controller: _tabController,
                    tabs: [
                      Tab(
                        text: 'Profile',
                      ),
                      Tab(
                        // text: 'Log out',

                        child: GestureDetector(
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
                            
                            }),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Container(
                  // height: MediaQuery.of(context).size.height,
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height,

                  child: TabBarView(
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        // IconWidget(iconData: Icons.access_alarm, txt: 'edit'),
                        EditProfile(),
                        Text('log out'),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // return GestureDetector(
    //     child: Text('Log out'),
    //     onTap: () {
    //       showDialog(
    //         context: context,
    //         builder: (context) => AlertDialog(
    //           title: Text("Log Out"),
    //           content: Text('Are you sure you want to Log Out?'),
    //           actions: [
    //             TextButton(
    //                 onPressed: () {
    //                   _auth.signOut();
    //                   UserSharedPreference.deleteUser();
    //                   Get.toNamed('/login');
    //                 },
    //                 child: Text('Yes')),
    //             TextButton(
    //                 onPressed: () => Navigator.pop(context), child: Text('No')),
    //           ],
    //         ),
    //       );
    //     });
  }
}
