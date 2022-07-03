import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:travelling_app/provider/add_trip_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:travelling_app/screens/Plan/add_plan_info_screen.dart';

class AddPlanScreen extends StatefulWidget {
  @override
  State<AddPlanScreen> createState() => _AddPlanScreenState();
  // late String startDate;
  // late String title;
  // late String duration;
  // AddPlanScreen(
  //     {required this.startDate, required this.title, required this.duration});
}

class _AddPlanScreenState extends State<AddPlanScreen> {
  final format = DateFormat('yyyy-MM-dd');
  late DateTime _selectedDate;

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<AddTripProvider>(
        builder: (context, addTripProvider, child) {
      // print('mainTtile is ${addTripProvider.mainTitle}');
      return SingleChildScrollView(
        child: Column(
          children: [
            // Text("startDate: ${addTripProvider.startDate}"),
            // Text("title: ${addTripProvider.mainTitle}"),
            // Text("duration: ${addTripProvider.durationDate}"),
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
                      MaterialButton(
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
                                selectedDate: _selectedDate,
                              );
                            },
                          ));
                        },
                        child: Text(
                          '+ Add Task',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            DatePicker(
             addTripProvider.startDate,
              initialSelectedDate: addTripProvider.startDate,
              selectionColor: Colors.black,
              selectedTextColor: Colors.white,
              daysCount: addTripProvider.durationDate+1,
              onDateChange: (date) {
                // New date selected
                setState(() {
                  _selectedDate = date;
                });
              },
            ),

            // SingleChildScrollView(

            //   child: Container(
            //     width: double.maxFinite,
            //     height: MediaQuery.of(context).size.height,
            // )
            // )
          ],
        ),
      );
    });
  }
}
