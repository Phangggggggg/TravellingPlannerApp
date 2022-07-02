class Trips {
  late String title;
  String? description;
  String? startTime;
  String? endTime;
  String? category;
  String? expense;

  Trips(
      {required this.title,
      this.description,
      this.startTime,
      this.endTime,
      this.category, 
      this.expense});
}
