import 'package:flutter/material.dart';
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
    AddPlanScreen(title: Get.arguments['title'],startDate: Get.arguments['startDate'],duration: Get.arguments['duration']),
    SearchScreen(),
  ];
    @override
  initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
      // context.read<AddTripProvider>().ininitListDays();
    // print('title: ${Get.arguments['title']}');
    // print('startDate: ${Get.arguments['startDate']}');
    // print('duration: ${Get.arguments['duration']}');
  
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(items: [
            BottomNavigationBarItem(
                  icon: Icon(Icons.assignment_rounded ),
                  label: 'Plan',
            ),
            BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
            )

      ],onTap: _onItemTapped, currentIndex: _selectedIndex, //RxInt,
            selectedItemColor: Colors.blue,)

     
    );
  }
}
