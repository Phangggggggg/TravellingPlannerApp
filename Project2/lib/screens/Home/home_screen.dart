import 'package:flutter/material.dart';
import 'package:travelling_app/widgets/add_trip_widget.dart';
import 'package:travelling_app/widgets/on_going_trip_widget.dart';
import 'package:travelling_app/widgets/recent_trip_widget.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return 
    SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('My Trips'),
                Icon(Icons.person,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Ongoing Trip"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AddTripWidget(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OnGoingTripWidget(placeName: 'def', dateOfGoing: '12/3/4'),
                )
              ],
            ),
          ), 
          Text('Recent Trips'),
          RecentTripWidget()
        ],
      ),
    );
  }
}
