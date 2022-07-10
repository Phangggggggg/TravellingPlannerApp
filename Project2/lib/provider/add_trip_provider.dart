import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:travelling_app/models/place_model.dart';
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
  late int count = 0;
  late bool isDoneSearch = false;
  late List<String> _listOfResId = [];
  late List<String> _listOfAccomId = [];
  late List<String> _listOfAttractId = [];

  bool isRebuild = false;

  List<PlaceModel> _listOfResPlaces = [];
  List<PlaceModel> _listOfAccomPlaces = [];
  List<PlaceModel> _listOfAttractPlaces = [];

  String? stateValue = "Bangkok";
  String? cityValue = "";

  void setProvince(String? provice) {
    stateValue = provice;
    notifyListeners();
  }

  void setIsRebuild(bool val) {
    isRebuild = val;
    notifyListeners();
  }

  void setIsDoneSearch(bool val) {
    isDoneSearch = val;
    notifyListeners();
  }

  void resetDisplayListOfTrip() {
    displayListOfTrip = [];
    listOfDays = [];
    notifyListeners();
  }

  void resetPlaces() {
    _listOfResId = [];
    _listOfAttractId = [];
    _listOfAccomId = [];
    _listOfResPlaces = [];
    _listOfAccomPlaces = [];
    _listOfAttractPlaces = [];
  }

  List<PlaceModel> get listOfResPlaces => _listOfResPlaces;
  List<PlaceModel> get listOfAccomPlaces => _listOfAccomPlaces;
  List<PlaceModel> get listOfAttractPlaces => _listOfAttractPlaces;

  Future<PlaceModel> getAResAttractAccomDetail(
      String place_id, String type) async {
    try {
      var uri1 =
          'https://tatapi.tourismthailand.org/tatapi/v5/${type}/${place_id}';

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
      var result = data['result'];
      return PlaceModel.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchLatLong(String province, String city) async {
    try {
      final where = Uri.encodeQueryComponent(jsonEncode({
        "adminName1": province,
        "placeName": city,
      }));

      final response = await http.get(
          Uri.parse(
              'https://parseapi.back4app.com/classes/TH?limit=10&where=$where'),
          headers: {
            "X-Parse-Application-Id":
                "zS2XAEVEZAkD081UmEECFq22mAjIvX2IlTYaQfai", // This is the fake app's application id
            "X-Parse-Master-Key":
                "t6EjVCUOwutr1ruorlXNsH3Rz65g0jiVtbILtAYU" // This is the fake app's readonly master key
          });
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch data');
      }
      final data = json.decode(response.body);
      var result = data['results'];
      count = data['count'];
      if (count != 0) {
        userLatitude = result['geoPosition']['latitude'].toString();
        userLongtitude = result['geoPosition']['latitude'].toString();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getAll(String lat, String long) async {
    resetPlaces();
    stateValue ??= 'Bangkok';
    print('here');
    await getAPlace('Food', '$lat+$long', stateValue!, 'RESTAURANT');
    await getAPlace('', '$lat+$long', stateValue!, 'ACCOMMODATION');
    await getAPlace('', '$lat+$long', stateValue!, 'ATTRACTION');
    notifyListeners();
    return true;
  }

  Future<void> getAPlace(String keyword, String geolocation,
      String provincename, String categorycodes) async {
    final queryParams = Uri.encodeQueryComponent(jsonEncode({
      "keyword": keyword,
      "location": geolocation,
      "provinceName": provincename,
      "categorycodes": categorycodes,
    }));

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

      if (categorycodes == 'RESTAURANT') {
        listOfResult.forEach((model) {
          _listOfResId.add(model['place_id']);
        });
        // getAResDetail(_listOfResId[0]).then((value) => print(value));
        _listOfResId.forEach((element) {
          getAResAttractAccomDetail(element, 'restaurant').then((value) {
            _listOfResPlaces.add(value);
          });
        });
      } else if (categorycodes == 'ACCOMMODATION') {
        listOfResult.forEach((model) {
          _listOfAccomId.add(model['place_id']);
        });
        _listOfAccomId.forEach((element) {
          getAResAttractAccomDetail(element, 'accommodation').then((value) {
            _listOfAccomPlaces.add(value);
          });
        });
      } else {
        listOfResult.forEach((model) {
          _listOfAttractId.add(model['place_id']);
        });
        _listOfAttractId.forEach((element) {
          getAResAttractAccomDetail(element, 'attraction').then((value) {
            _listOfAttractPlaces.add(value);
          });
        });
      }
    } catch (e) {
      print(e);
    }
  }

  List<String> get listOfResId => _listOfResId;

  List<String> get listOfAccomId => _listOfAccomId;

  List<String> get listOfAttractId => _listOfAttractId;

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
