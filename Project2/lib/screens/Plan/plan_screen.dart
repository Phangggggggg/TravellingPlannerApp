import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  var _isInit = true;
  var _isLoading = false;

  static List<Widget> _widgetOptions = <Widget>[
    //title: Get.arguments['title'], startDate: Get.arguments['startDate'], duration: Get.arguments['duration']
    AddPlanScreen(), SearchScreen(),
  ];
  late String lat;
  late String long;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var auth = context.read<AddTripProvider>();
    lat = auth.userLatitude;
    long = auth.userLongtitude;
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<AddTripProvider>(context)
          .getAPlace('Food', '$lat+$long', 'Bangkok', 'RESTAURANT')
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
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

    return Scaffold(
        body: _isLoading ? Center(child: CircularProgressIndicator(color: Colors.red),) : _widgetOptions.elementAt(_selectedIndex),
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
          selectedItemColor: Colors.blue,
        ));
  }
}
