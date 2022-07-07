import 'package:flutter/material.dart';
import 'package:travelling_app/models/main_trip_model.dart';
import 'package:travelling_app/utils/user_shared_preferences.dart';
import 'package:travelling_app/widgets/add_trip_widget.dart';
import 'package:travelling_app/widgets/on_going_trip_widget.dart';
import 'package:travelling_app/widgets/recent_trip_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '/models/days.dart';
import '/models/trips.dart';
import '/models/main_trip_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FirebaseFirestore _firestore;
  List<MainTripModel> onGoingTrip = [];
  List<MainTripModel> recentTrip = [];
  var _isInit = true;
  var _isLoading = false;

  Future iniFirebase() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
  }

  @override
  void initState() {
    super.initState();
    iniFirebase().then((_) {
      setState(() {
        _isLoading = true;
      });
      getInfo().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  Future getInfo() async {
    final tripInformations = await _firestore
        .collection('travelTracker')
        .where('userId', isEqualTo: UserSharedPreference.getUser()[0])
        .snapshots()
        .listen((data) {
      for (var info in data.docs) {
        List<dynamic> listOfDays = info['listOfDays'];
        List<Days> listDays = [];
        for (var j = 0; j < listOfDays.length; j++) {
          List<dynamic> listOfTrips = listOfDays[j]['listOfTrips'];
          List<Trips> listTrips = [];
          for (var i = 0; i < listOfTrips.length; i++) {
            Trips trip = new Trips(
                title: listOfTrips[i]['title'],
                description: listOfTrips[i]['description'],
                startTime: listOfTrips[i]['startTime'],
                endTime: listOfTrips[i]['endTime'],
                category: listOfTrips[i]['category'],
                expense: listOfTrips[i]['expense']);

            listTrips.add(trip);
          }
          Days eachDay = Days(
            title: info['mainTitle'],
            date: DateTime.parse(listOfDays[j]['date']),
            trips: listTrips,
          );

          listDays.add(eachDay);
        }
        MainTripModel mainTripModel = new MainTripModel(
            mainTitle: info['mainTitle'],
            stratDate: info['startDate'],
            endDate: info['endDate'],
            userId: info['userId'],
            listOfDays: listDays);
        setState(() {
          recentTrip.add(mainTripModel);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
            color: Colors.blueAccent,
          ))
        : SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('My Trips'),
                      Icon(
                        Icons.person,
                      ),
                    ],
                  ),
                ),
                // TextButton(
                //     onPressed: () {
                //       getInfo();
                //     },
                //     child: const Text('Submit')),
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
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: OnGoingTripWidget(
                      //       placeName: 'def', dateOfGoing: '12/3/4'),
                      // )
                    ],
                  ),
                ),
                Text('Recent Trips'),
                RecentTripWidget(lst: recentTrip),
              ],
            ),
          );
  }
}
