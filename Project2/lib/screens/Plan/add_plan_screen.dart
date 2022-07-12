import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:travelling_app/colors/colors.dart';
import 'package:travelling_app/models/place_model.dart';
import 'package:travelling_app/provider/add_trip_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:travelling_app/screens/Plan/add_plan_info_screen.dart';
import 'package:travelling_app/widgets/show_plan_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '/utils/user_shared_preferences.dart';
import 'package:travelling_app/colors/colors.dart';

class AddPlanScreen extends StatefulWidget {
  @override
  State<AddPlanScreen> createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends State<AddPlanScreen> {
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

  // late DateTime _selectedDate = context.read<AddTripProvider>().startDate;
  // late FirebaseFirestore _firestore;

  // void iniFirebase() async {
  //   await Firebase.initializeApp();
  //   _firestore = FirebaseFirestore.instance;
  // }

  @override
  void initState() {
    super.initState();
    // iniFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddTripProvider>(
        builder: (context, addTripProvider, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Text(
            //     'Plan your trip',
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 30,
            //       color: kBrown,
            //     ),
            //   ),
            // ),
            // Text('SelectedDay is ${addTripProvider.selectedDay}'),
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 3),
              child: Column(
                children: [
                  // MaterialButton(
                  //   minWidth: 30.0,
                  //   height: 30.0,
                  //   color: kRed,
                  //   shape: const RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  //   ),
                  //   onPressed: () async {
                  //     var listDays = [];
                  //     var days = addTripProvider.listOfDays;
                  //     for (var i = 0; i < addTripProvider.listOfDays.length; i++) {
                  //       var listTrips = [];
                  //       var trips = addTripProvider.listOfDays[i].trips!;
                  //       for (var j = 0; j < trips.length; j++) {
                  //         if (trips[j].placeModel == null) {
                  //           dynamic tripsObj = {
                  //             'category': trips[j].category,
                  //             'description': trips[j].description,
                  //             'endTime': trips[j].endTime,
                  //             'startTime': trips[j].startTime,
                  //             'expense': trips[j].expense,
                  //             'title': trips[j].title,
                  //           };
                  //           listTrips.add(tripsObj);
                  //         } else {
                  //           PlaceModel placeModel = trips[j].placeModel!;
                  //           dynamic tripsObj = {
                  //             'category': trips[j].category,
                  //             'description': trips[j].description,
                  //             'endTime': trips[j].endTime,
                  //             'startTime': trips[j].startTime,
                  //             'expense': trips[j].expense,
                  //             'title': trips[j].title,
                  //             'placeModel': {
                  //               'placeId': placeModel.placeId,
                  //               'placeName': placeModel.placeName,
                  //               'latitude': placeModel.latitude,
                  //               'longitude': placeModel.longitude,
                  //               'shaTypeDescription': placeModel.shaTypeDescription,
                  //               'introduction': placeModel.introduction,
                  //               'detial': placeModel.detial,
                  //               'address': placeModel.address,
                  //               'subDistrict': placeModel.subDistrict,
                  //               'district': placeModel.district,
                  //               'province': placeModel.province,
                  //               'postcode': placeModel.postcode,
                  //               'phones': placeModel.phones,
                  //               'picUrl': placeModel.picUrl,
                  //             }
                  //           };
                  //           listTrips.add(tripsObj);
                  //         }
                  //       }
                  //       ;

                  //       dynamic daysObj = {
                  //         'date': (days[i].date).toString(),
                  //         'listOfTrips': listTrips
                  //       };
                  //       listDays.add(daysObj);
                  //     }
                  //     Map<String, dynamic> travelData = {
                  //       'endDate': addTripProvider.endDate.toString(),
                  //       'startDate': addTripProvider.startDate.toString(),
                  //       'mainTitle': addTripProvider.mainTitle,
                  //       'userId': UserSharedPreference.getUser()[0],
                  //       'listOfDays': listDays
                  //     };

                  //     await _firestore.collection('travelTracker').add(travelData);
                  //     addTripProvider.resetDisplayListOfTrip();
                  //     Get.toNamed('/home');
                  //   },
                  //   child: const Text(
                  //     'Trip Completed',
                  //     style: TextStyle(color: Colors.white),
                  //   )
                  // ),
                  
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                          minWidth: 20.0,
                          height: 20.0,
                          color: kRajah,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                          onPressed: () {
                            addTripProvider.setEndDate(1);
                            addTripProvider.setDuration(1);
                            DateTime endDate = addTripProvider.endDate;
                            addTripProvider.addDays(endDate);
                          },
                          child: Text(
                            '+',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        // Text('Today\'s ${formatDate(DateTime.now())}', style: TextStyle(
                        //   // fontWeight: FontWeight.bold,
                        //   color: kBrown,
                        //   ),
                        // ),
                        MaterialButton(
                          minWidth: 20.0,
                          height: 20.0,
                          color: kRajah,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                          onPressed: () {
                            addTripProvider.setEndDate(-1);
                            addTripProvider.setDuration(-1);
                            addTripProvider.removeDays();
                          },
                          child: Text(
                            '-',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                  ),
                ]
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
              child: DatePicker(
                addTripProvider.startDate,
                initialSelectedDate: addTripProvider.selectedDay,
                selectionColor: kRed,
                selectedTextColor: Colors.white,
                daysCount: addTripProvider.durationDate + 1,
                onDateChange: (date) {
                  // New date selected

                  addTripProvider.setSelectDate(date);
                  addTripProvider.getListByDate(date);
                
                },
              ),
            ),

            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 303,
                child: ShowPlanWidget(lst: addTripProvider.displayListOfTrip, isShowSlider: true,)),
          ],
        ),
      );
    });
  }
}
