import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:travelling_app/colors/colors.dart';
import 'package:travelling_app/screens/Plan/add_plan_screen.dart';
import 'package:travelling_app/screens/Plan/search.dart';
import 'package:provider/provider.dart';

import 'package:get/get.dart';
import '../../provider/add_trip_provider.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  int _selectedIndex = 0;


  static List<Widget> _widgetOptions = <Widget>[
    //title: Get.arguments['title'], startDate: Get.arguments['startDate'], duration: Get.arguments['duration']
    AddPlanScreen(), SearchScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<AddTripProvider>().ininitListDays();
    });
    // var auth = context.read<AddTripProvider>();
    // if (!_isLoading) {
    //   print(auth.listOfResPlaces.length);
    //   print('______________');
    //   print(auth.listOfAccomPlaces.length);
    //   print('______________');
    //   print(auth.listOfAttractPlaces.length);
    // }
    // print(auth.listOfResPlaces);

    return SafeArea(

      child: Scaffold(
        backgroundColor: kWheat,
          body:
               _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment_rounded),
                label: 'Plan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              )
            ],
            onTap: _onItemTapped,
            currentIndex: _selectedIndex, //RxInt,
            selectedItemColor: kRed,
          )),
    );
  }
}
