import 'package:flutter/material.dart';
import 'package:travelling_app/provider/add_trip_provider.dart';
import 'package:travelling_app/provider/covid_provider.dart';
import 'package:travelling_app/screens/Home/RecentTrip/recent_trip_detail.dart';
import 'package:travelling_app/screens/Home/home.dart';
import 'package:travelling_app/screens/Plan/add_plan_info_screen.dart';
import 'package:travelling_app/screens/Plan/plan_screen.dart';
import 'package:travelling_app/screens/Authentication/register.dart';
import 'package:travelling_app/widgets/search_widgets/province_search_widget.dart';
import 'screens/Authentication/login.dart';
import 'package:get/get.dart';
import 'screens/Authentication/register.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'utils/user_shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await UserSharedPreference.init(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: AddTripProvider(),
          ),
          ChangeNotifierProvider.value(
            value: CovidProvider(),
          )
        ],
        child: GetMaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: UserSharedPreference.getUser().isNotEmpty ? '/home':'/login',
            getPages: [
              // GetPage(name: '/', page: () => ProvinceSearchWidget(province: 'Bangkok',city: 'Taling Chan')),
              GetPage(name: '/home', page: () => Home()),
              GetPage(name: '/register', page: () => Register()),
              GetPage(name: '/login', page: () => Login()),
              GetPage(name:  '/plan', page: () =>  PlanScreen()),
            ]));
  }
}
