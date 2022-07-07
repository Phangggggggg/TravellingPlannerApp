import 'days.dart';

class MainTripModel {
  late String mainTitle;
  late String stratDate; 
  late String endDate; 
  late String userId; 
  late List<Days> listOfDays;

 MainTripModel({
    required this.mainTitle,
    required this.stratDate,
    required this.endDate,
    required this.userId,
    required this.listOfDays
 });
}
