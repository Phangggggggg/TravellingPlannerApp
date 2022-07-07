import 'package:flutter/material.dart';
import 'package:travelling_app/models/main_trip_model.dart';

class TripWidget extends StatelessWidget {
  String mainTitle;
  String startDate;
  String endDate;

  TripWidget(
      {required this.mainTitle,
      required this.startDate,
      required this.endDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(mainTitle),
          Text(startDate),
          Text(endDate),
        ],
      ),
    );
  }
}
