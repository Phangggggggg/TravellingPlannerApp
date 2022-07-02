import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/days.dart';
import '../models/trips.dart';

class AddTripProvider with ChangeNotifier {
  late final DateTime startDate;
  late final int durationDate;
  late final List<Days> listOfDays = [];
  late final String mainTitle;

  void initListPlansByDate(DateTime date) {
    List<Trips> lstTrips = [];
    Days day = Days(date: date, trips: lstTrips, title: mainTitle);
    listOfDays.add(day);
    notifyListeners();
  }

  void ininitListDays() {
    for (var i = 0; i <= durationDate; i++) {
      initListPlansByDate(startDate.add(Duration(days: i)));
    }
    notifyListeners();
  }

  void addTripByDate(DateTime date, Trips trip) {
    try {
      var result =
          listOfDays.firstWhere((day) => DateUtils.isSameDay(date, day.date));
      result.trips!.add(trip);
      printListOfDays();
    } catch (e) {
      print(e);
    }
  }

  void printListOfDays() {
    listOfDays.forEach((element) {
      print('Day : ${element.date}');
      element.trips?.forEach((val) {
        print('Title: ${val.title}');
        print('Description: ${val.description}');
        print('Start Time: ${val.startTime}');
        print('Start Time: ${val.endTime}');
        print('Start Time: ${val.category}');
        print('Expense: ${val.expense}');
      });
    });
  }

  void initInstancs(String title, DateTime date, int duration) {
    mainTitle = title;
    startDate = date;
    durationDate = duration;
    notifyListeners();
  }
}
