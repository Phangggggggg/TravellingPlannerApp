import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AddTripProvider with ChangeNotifier {
  late final DateTime startDate;
  late final int durationDate;

  void setStartDate(DateTime date){
    startDate = date;
    notifyListeners();
  }

  void setDuration(int duration){
    durationDate = duration;
    notifyListeners();
  }
}
