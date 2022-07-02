import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:travelling_app/provider/add_trip_provider.dart';
import 'package:provider/provider.dart';

class AddPlanScreen extends StatefulWidget {

  @override
  State<AddPlanScreen> createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends State<AddPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddTripProvider>(
      builder: (context,addTripProvider, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              DatePicker(
                DateTime.now(),
                initialSelectedDate: addTripProvider.startDate,
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
                daysCount: addTripProvider.durationDate+1,
                onDateChange: (date) {
                  // New date selected
                  // setState(() {
                  //   _selectedValue = date;
                  // });
                },
              ),
            ],
          ),
        );
      }
    );
  }
}
