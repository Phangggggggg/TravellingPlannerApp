import 'package:flutter/material.dart';
import 'package:travelling_app/provider/add_trip_provider.dart';
import 'package:travelling_app/screens/Home/home.dart';
import 'package:travelling_app/screens/Home/try.dart';
import 'package:travelling_app/screens/Plan/add_plan_info_screen.dart';
import 'package:travelling_app/screens/Plan/plan_screen.dart';
import 'package:travelling_app/screens/Authentication/register.dart';
import 'screens/Authentication/login.dart';
import 'package:get/get.dart';
import 'screens/Authentication/register.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
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
        ],
        child: GetMaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            getPages: [
              GetPage(name: '/', page: () => MyLocation()),
              GetPage(name: '/register', page: () => Register()),
              GetPage(name: '/login', page: () => Login()),
              // GetPage(name: '/register', page: () => Register()),
              // GetPage(name:  '/plan', page: () =>  PlanScreen())
            ]));
  }
}
