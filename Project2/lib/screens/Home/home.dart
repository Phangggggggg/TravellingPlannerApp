import 'package:flutter/material.dart';
import 'package:travelling_app/screens/Home/covid.dart';
import 'package:travelling_app/screens/Home/setting_screen.dart';

import 'home_screen.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

    int _selectedIndex = 0;

   static const List<Widget> _widgetOptions = <Widget>[
    
    HomeScreen(),
    CovidScreen(),
    SettingScreen()
 
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
    return SafeArea(
        child: Scaffold(
          body:
           _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                top: BorderSide(width: 1.0, color: Colors.grey.shade200))),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_rounded ),
              label: 'Covid',
            ),
            BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Setting',
                ),
          ],
            currentIndex: _selectedIndex, //RxInt,
            selectedItemColor: Colors.blue,
              // unselectedItemColor:kBlue,
            onTap: _onItemTapped)
        ),
      ),
    );
  }
}
