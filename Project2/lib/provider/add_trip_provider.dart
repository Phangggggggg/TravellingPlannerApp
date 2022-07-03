import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/days.dart';
import '../models/trips.dart';

class AddTripProvider with ChangeNotifier {
  late DateTime startDate = DateTime.now();
  late DateTime endDate = DateTime.now();
  late int durationDate = 1;
  late List<Days> listOfDays = [];
  late String mainTitle = "";
  late List<Trips> displayListOfTrip = [];
  late DateTime selectedDay = DateTime.now();

  void ininitListDays() {
    if (listOfDays.isEmpty) {
      for (var i = 0; i <= durationDate; i++) {
        initListPlansByDate(startDate.add(Duration(days: i)));
      }

      notifyListeners();
    }
  }

  void setEndDate(int duration) {
    endDate = endDate.add(Duration(days: duration));
    notifyListeners();
  }

  void setDuration(int duration) {
    durationDate += duration;
    notifyListeners();
  }

  void removeDays() {
    listOfDays.removeLast();
  }

  void addDays(DateTime date) {
    List<Trips> lstTrips = [];
    Days day = Days(date: date, title: mainTitle, trips: lstTrips);
    listOfDays.add(day);
    notifyListeners();
  }

  void setSelectDate(DateTime date) {
    selectedDay = date;
    notifyListeners();
  }

  void initListPlansByDate(DateTime date) {
    List<Trips> lstTrips = [];
    Days day = Days(date: date, trips: lstTrips, title: mainTitle);
    listOfDays.add(day);
  }

  void getListByDate(DateTime date) {
    try {
      // print('here');
      displayListOfTrip = listOfDays
          .firstWhere((day) => DateUtils.isSameDay(date, day.date))
          .trips!;

      // print(displayListOfTrip);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void removeTripByDate(int index) {
    try {
      var result = listOfDays
          .firstWhere((day) => DateUtils.isSameDay(selectedDay, day.date))
          .trips;
      if (result!.isNotEmpty) {
        result.removeAt(index);
      }
      displayListOfTrip = result;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void addTripByDate(DateTime date, Trips trip) {
    try {
      var result =
          listOfDays.firstWhere((day) => DateUtils.isSameDay(date, day.date));
      result.trips!.add(trip);
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

  void initInstancs(
      String title, DateTime startDay, int duration, DateTime endDay) {
    mainTitle = title;
    startDate = startDay;
    endDate = endDay;
    durationDate = duration;
    selectedDay = startDate;
    notifyListeners();
  }
}
