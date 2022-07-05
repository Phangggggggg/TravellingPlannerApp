import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';


class Display extends StatefulWidget {
  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
  }
  

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.values[0],
        labelColor: Colors.black12,
        unselectedLabelColor: Colors.grey,
        controller: _tabController,
           isScrollable: true
,
         tabs: [
          Tab(

            icon: Icon(Icons.restaurant, color:  Colors.black),   
            child: Text(
            'Restaurant',
            style: TextStyle(
              color:  Colors.black,
              fontSize: 15,
              // fontWeight: FontWeight.bold,
            ),),
          ),
          Tab(

            icon: Icon(Icons.hotel, color:  Colors.black),   
              child: Text(
            'Accommodation',
            style: TextStyle(
              color:  Colors.black,
              fontSize: 15,
              // fontWeight: FontWeight.bold,
            ),
          )),
          Tab(
            icon: Icon(Icons.attractions, color: Colors.black),  
            child: Text(
              'Attraction',
              style: TextStyle(
                color:  Colors.black,
                fontSize: 15,
                // fontWeight: FontWeight.bold,
              ),
            ),
          )
         ]
    );
     SingleChildScrollView(
      child: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height,
          child:
            TabBarView(controller: _tabController, children: [

            ]
          )
      )

     );

  }

}

