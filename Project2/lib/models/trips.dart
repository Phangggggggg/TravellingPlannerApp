import 'package:travelling_app/models/place_model.dart';

class Trips {
  late String title;
  String? description;
  String? startTime;
  String? endTime;
  String? category;
  String? expense;
  PlaceModel? placeModel;

  Trips(
      {required this.title,
      this.description,
      this.startTime,
      this.endTime,
      this.category,
      this.expense,
      this.placeModel});
}
