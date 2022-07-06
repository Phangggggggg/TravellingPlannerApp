import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import '../api/get_url.dart';
import '../models/days.dart';
import '../models/trips.dart';
import 'dart:convert';

class AddTripProvider with ChangeNotifier {
  late DateTime startDate = DateTime.now();
  late DateTime endDate = DateTime.now();
  late int durationDate = 1;
  late List<Days> listOfDays = [];
  late String mainTitle = "";
  late List<Trips> displayListOfTrip = [];
  late DateTime selectedDay = DateTime.now();
  late String userLatitude = '13.756331';
  late String userLongtitude = '100.501762';
  late List<String> _listOfResId = [];

  String? stateValue = "";
  String? cityValue = "";

  void setProvince(String? provice) {
    stateValue = provice;
    notifyListeners();
  }

  Future<void> getAPlace(String keyword, String geolocation,
      String provincename, String categorycodes) async {
    final queryParams = Uri.encodeQueryComponent(jsonEncode({
      "keyword": keyword,
      "location": geolocation,
      "provinceName": provincename,
      "categorycodes": categorycodes,
    }));
    List<String> ans = [];
    try {
      var uri1 = 'https://tatapi.tourismthailand.org/tatapi/v5/places/search?' +
          'keyword=${keyword}' +
          "&" +
          'location=${geolocation}' +
          '&' +
          'categorycodes=${categorycodes}'
              '&' +
          'provinceName=${provincename}';
      var res = await http.get(
        Uri.parse(uri1),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer ${GetUrl.tat}',
          'Accept-Language': 'en'
        },
      );
      if (res.statusCode != 200) {
        throw Exception('Failed to fetch get place data');
      }
      final data = json.decode(res.body);
      var listOfResult = data['result'].toList();
      listOfResult.forEach((model) {
        _listOfResId.add(model['place_id']);
      });
          notifyListeners();

    } catch (e) {
      print(e);
    }
  
  }

  List<String> get listOfResId => _listOfResId;

  void setUserLatLong(String lat, String long) {
    userLatitude = lat;
    userLongtitude = long;
    notifyListeners();
  }

  void setCity(String? city) {
    cityValue = city;
    notifyListeners();
  }

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
