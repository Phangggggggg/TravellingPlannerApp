import 'package:flutter/material.dart';
import 'package:travelling_app/models/main_trip_model.dart';
import 'package:intl/intl.dart';

class TripWidget extends StatelessWidget {
  String mainTitle;
  String startDate;
  String endDate;
  int duration;

  TripWidget(
      {required this.mainTitle,
      required this.startDate,
      required this.endDate,
      required this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
        Row(
          children: [
            Icon(Icons.card_travel, color: Colors.black),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                mainTitle,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text( 'From '+
            DateFormat.yMMMd().format(DateTime.parse(startDate)),
            style: TextStyle(color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text( 'To ' + DateFormat.yMMMd().format(DateTime.parse(endDate)),
              style: TextStyle(color: Colors.black)),
        ),
        Row(
          children: [
            Icon(Icons.timelapse, color: Colors.black),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Text(duration.toString() + ' Days', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ]),
    );
  }
}
