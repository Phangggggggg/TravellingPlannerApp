import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
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

class AddPlanScreen extends StatefulWidget {
  @override
  State<AddPlanScreen> createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends State<AddPlanScreen> {
  final format = DateFormat('yyyy-MM-dd');
  // late DateTime _selectedDate = context.read<AddTripProvider>().startDate;
  late FirebaseFirestore _firestore;

  void iniFirebase() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
  }

  @override
  void initState() {
    super.initState();
    iniFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddTripProvider>(
        builder: (context, addTripProvider, child) {
      return Column(
        children: [
          // Text('SelectedDay is ${addTripProvider.selectedDay}'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_circle_left_sharp,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    print('back button is pressed');
                    Get.back();
                  },
                ),
                Text(format.format(DateTime.now())),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 80, 0.0),
                      child: MaterialButton(
                        minWidth: 50.0,
                        height: 50.0,
                        color: Colors.blue,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return AddPlanInfoScreen(
                                selectedDate: addTripProvider.selectedDay,
                              );
                            },
                          ));
                        },
                        child: Text(
                          '+ Add Task',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
            child: DatePicker(
              addTripProvider.startDate,
              initialSelectedDate: addTripProvider.selectedDay,
              selectionColor: Colors.black,
              selectedTextColor: Colors.white,
              daysCount: addTripProvider.durationDate + 1,
              onDateChange: (date) {
                // New date selected

                addTripProvider.setSelectDate(date);
                addTripProvider.getListByDate(date);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 80, 0.0),
            child: MaterialButton(
              minWidth: 30.0,
              height: 30.0,
              color: Colors.blue,
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 80, 0.0),
            child: MaterialButton(
              minWidth: 30.0,
              height: 30.0,
              color: Colors.blue,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              onPressed: () {
                addTripProvider.setEndDate(1);
                addTripProvider.setDuration(1);
                DateTime endDate = addTripProvider.endDate;
                addTripProvider.addDays(endDate);

                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) {
                //     return AddPlanInfoScreen(
                //       seRlectedDate: addTripProvider.selectedDay,
                //     );
                //   },
                // ));
              },
              child: Text(
                '+',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                var listDays = [];
                var days = addTripProvider.listOfDays;
                for (var i = 0; i < addTripProvider.listOfDays.length; i++) {
                  var listTrips = [];
                  var trips = addTripProvider.listOfDays[i].trips!;
                  for (var j = 0; j < trips.length; j++) {
                    dynamic tripsObj = {
                      'category': trips[j].category,
                      'description': trips[j].description,
                      'endTime': trips[j].endTime,
                      'startTime': trips[j].startTime,
                      'expense': trips[j].expense,
                      'title': trips[j].title,
                    };

                    listTrips.add(tripsObj);
                  }
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

                _firestore.collection('travelTracker').add(travelData);
                addTripProvider.resetDisplayListOfTrip();
                Get.toNamed('/home');
              },
              child: const Text('Submit')),

          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 303,
              child: ShowPlanWidget(lst: addTripProvider.displayListOfTrip)),
        ],
      );
    });
  }
}
