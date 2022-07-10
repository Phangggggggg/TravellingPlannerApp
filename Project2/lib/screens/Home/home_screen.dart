import 'package:flutter/material.dart';
import 'package:travelling_app/models/main_trip_model.dart';
import 'package:travelling_app/models/place_model.dart';
import 'package:travelling_app/utils/user_shared_preferences.dart';
import 'package:travelling_app/widgets/add_trip_widget.dart';
import 'package:travelling_app/widgets/recent_trip_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '/models/days.dart';
import '/models/trips.dart';
import '/models/main_trip_model.dart';
import 'package:get/get.dart';

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
        print('Future finished successfully i.e. without error');
      }).catchError((error) {
        print('Future finished with error');
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
        print('Either of then or catchError has run at this point');
      });
    });
  }

  Future<bool> getInfo() async {
    try {
      final tripInformations = await _firestore
          .collection('travelTracker')
          .where('userId', isEqualTo: UserSharedPreference.getUser()[0])
          .snapshots()
          .listen((data) {
        // print(data.docs[0]);
        if (data.docs.isNotEmpty) {
          for (var info in data.docs) {
            List<dynamic> listOfDays = info['listOfDays'];
            List<Days> listDays = [];

            for (var j = 0; j < listOfDays.length; j++) {
              List<dynamic> listOfTrips = listOfDays[j]['listOfTrips'];
              List<Trips> listTrips = [];

              for (var i = 0; i < listOfTrips.length; i++) {
                if (listOfTrips[j]['placeModel'] == null) {
                  Trips trip = new Trips(
                      title: listOfTrips[i]['title'],
                      description: listOfTrips[i]['description'],
                      startTime: listOfTrips[i]['startTime'],
                      endTime: listOfTrips[i]['endTime'],
                      category: listOfTrips[i]['category'],
                      expense: listOfTrips[i]['expense']);
                      listTrips.add(trip);
                } else {
                  var pm = listOfTrips[i]['placeModel'];
                  Trips trip = new Trips(
                      title: listOfTrips[i]['title'],
                      description: listOfTrips[i]['description'],
                      startTime: listOfTrips[i]['startTime'],
                      endTime: listOfTrips[i]['endTime'],
                      category: listOfTrips[i]['category'],
                      expense: listOfTrips[i]['expense'],
                      placeModel: PlaceModel.fromJsonFireBase(pm));
                  listTrips.add(trip);
                }
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
                docId: info.id,
                listOfDays: listDays);
            setState(() {
              recentTrip.add(mainTripModel);
            });
          }
        }
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(color: Colors.amberAccent),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Trips',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.toNamed('/profile');
                        },
                        icon: Icon(Icons.person),
                      ),
                    ],
                  ),
                  // TextButton(
                  //     onPressed: () {
                  //       getInfo();
                  //     },
                  //     child: const Text('Submit')),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Ongoing Trip",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      AddTripWidget(),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: OnGoingTripWidget(
                      //       placeName: 'def', dateOfGoing: '12/3/4'),
                      // )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Recent Trips',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  // Text('length ${recentTrip.length.toString()}')
                  SizedBox(
                    height: 20,
                  ),
                  RecentTripWidget(lst: recentTrip),
                ],
              ),
            ),
          );
  }
}
