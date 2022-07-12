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
import 'package:travelling_app/colors/colors.dart';
import 'package:intl/intl.dart';

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
  int _numTrips = 0;

  final format = DateFormat('yyyy-MM-dd');

  String formatDate(DateTime date) {
    String now;
    try {
      now = DateFormat.yMMMd().format(date);
    } catch (e) {
      now = "";
    }

    return now;
  }

  Future iniFirebase() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
  }

  int getNumTrips(List<MainTripModel> lst) {
    return lst.isEmpty ? 0 : lst.length;
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
                if (listOfTrips[i]['placeModel'] == null) {
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
          setState(() {
            _numTrips = getNumTrips(recentTrip);
          });
        }
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var squareWidth = MediaQuery.of(context).size.width / 2 - 20; 

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
                    children: [
                      Text(
                        'My Trips',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: kBrown,
                            fontFamily: 'Aeonik'),
                      ),
    
                    ],
                  ),
                   SizedBox(
                    height: 5,
                  ),
                  Container(height: 5, width: MediaQuery.of(context).size.width/5 + 5, 
                                  color: kDesire),
                  Container(height: 5, width: MediaQuery.of(context).size.width/5 + 15, 
                                  color: kRajah),
                                  
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add your Trip",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: kBrown,
                            fontFamily: 'Aeonik'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80, 10, 0, 0),
                        child: Text('Today\'s ${formatDate(DateTime.now())}'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AddTripWidget(),
                      InkWell(
                        onTap: () {
                        },
                        child: Container(
                        
                          width: squareWidth,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("lib/assets/logos/thai.png"),
                                  fit: BoxFit.cover),
                          ),
                          height: squareWidth,
                            child: Center(
                              child: 
                              Text('Number of \n     Trips\n        ${_numTrips}'),
                              // child: Icon(
                              //   Icons.add,
                              //   size: 30,
                              //   color: Colors.grey,
                              // ),
                            ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    'Recent Trips',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBrown,
                        fontFamily: 'Aeonik',
                        fontSize: 20),
                  ),
                  // Text('length ${recentTrip.length.toString()}')
                  SizedBox(
                    height: 15,
                  ),
                  RecentTripWidget(lst: recentTrip),
                ],
              ),
            ),
          );
  }
}
