import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:travelling_app/colors/colors.dart';
import 'package:travelling_app/screens/Plan/add_plan_screen.dart';
import 'package:travelling_app/screens/Plan/search.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../../provider/add_trip_provider.dart';
import 'package:travelling_app/screens/Plan/add_plan_info_screen.dart';
import 'package:provider/provider.dart';
import 'package:travelling_app/provider/add_trip_provider.dart';
import 'package:travelling_app/models/place_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '/utils/user_shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  int _selectedIndex = 0;

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

  static List<Widget> _widgetOptions = <Widget>[
    //title: Get.arguments['title'], startDate: Get.arguments['startDate'], duration: Get.arguments['duration']
    AddPlanScreen(), SearchScreen(),
  ];

  @override
  void initState() {
    super.initState();
    iniFirebase();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

   late FirebaseFirestore _firestore;

  void iniFirebase() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<AddTripProvider>().ininitListDays();
    });
  

    return SafeArea(
      child: Consumer<AddTripProvider>(
        builder: (context, addTripProvider,child) {
          return Scaffold(
              appBar: _selectedIndex == 0 ?  AppBar(
                backgroundColor: kDesire,
                title:  Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text('Today\'s ${formatDate(DateTime.now())}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: MaterialButton(
                          minWidth: 7.0,
                          height: 30.0,
                          color: kWheat,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                          onPressed: () async {
                            var listDays = [];
                            var days = addTripProvider.listOfDays;
                            for (var i = 0; i < addTripProvider.listOfDays.length; i++) {
                              var listTrips = [];
                              var trips = addTripProvider.listOfDays[i].trips!;
                              for (var j = 0; j < trips.length; j++) {
                                if (trips[j].placeModel == null) {
                                  dynamic tripsObj = {
                                    'category': trips[j].category,
                                    'description': trips[j].description,
                                    'endTime': trips[j].endTime,
                                    'startTime': trips[j].startTime,
                                    'expense': trips[j].expense,
                                    'title': trips[j].title,
                                  };
                                  listTrips.add(tripsObj);
                                } else {
                                  PlaceModel placeModel = trips[j].placeModel!;
                                  dynamic tripsObj = {
                                    'category': trips[j].category,
                                    'description': trips[j].description,
                                    'endTime': trips[j].endTime,
                                    'startTime': trips[j].startTime,
                                    'expense': trips[j].expense,
                                    'title': trips[j].title,
                                    'placeModel': {
                                      'placeId': placeModel.placeId,
                                      'placeName': placeModel.placeName,
                                      'latitude': placeModel.latitude,
                                      'longitude': placeModel.longitude,
                                      'shaTypeDescription': placeModel.shaTypeDescription,
                                      'introduction': placeModel.introduction,
                                      'detial': placeModel.detial,
                                      'address': placeModel.address,
                                      'subDistrict': placeModel.subDistrict,
                                      'district': placeModel.district,
                                      'province': placeModel.province,
                                      'postcode': placeModel.postcode,
                                      'phones': placeModel.phones,
                                      'picUrl': placeModel.picUrl,
                                    }
                                  };
                                  listTrips.add(tripsObj);
                                }
                              }
                              ;
      
                              dynamic daysObj = {
                                'date': (days[i].date).toString(),
                                'listOfTrips': listTrips
                              };
                              listDays.add(daysObj);
                            }
                            Map<String, dynamic> travelData = {
                              'endDate': addTripProvider.endDate.toString(),
                              'startDate': addTripProvider.startDate.toString(),
                              'mainTitle': addTripProvider.mainTitle,
                              'userId': UserSharedPreference.getUser()[0],
                              'listOfDays': listDays
                            };
      
                            await _firestore.collection('travelTracker').add(travelData);
                            addTripProvider.resetDisplayListOfTrip();
                            Get.toNamed('/home');
                          },
                          child: Row(
        
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: FaIcon(FontAwesomeIcons.clipboardCheck, color: kBrown, size: 18,),
                              ),
                              const Text(
                                'Completed',
                                style: TextStyle(color: kBrown),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                
              ) : null,
              backgroundColor: kWheat,
              body: _widgetOptions.elementAt(_selectedIndex),
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
              ), 
              floatingActionButton: _selectedIndex == 0 ?  FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return AddPlanInfoScreen(
                                      selectedDate: context.read<AddTripProvider>().selectedDay,
                                    );
                                  },
                ));
              },
              label: const Text('+ Add Trip') ,
              // icon:FaIcon(FontAwesomeIcons.fileInvoiceDollar),
              backgroundColor: kRajah, 
            ) : null);
        }
      ),
    );
  }
}
