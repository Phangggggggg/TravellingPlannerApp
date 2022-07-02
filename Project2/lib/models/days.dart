import 'package:travelling_app/models/trips.dart';

class Days {
  late DateTime date;
  late String title;
  List<Trips>? trips;
  Days({required this.date, required this.title,this.trips});
}
