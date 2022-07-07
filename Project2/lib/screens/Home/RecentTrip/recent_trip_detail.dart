import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../models/days.dart';
import '../../../models/trips.dart';
import '../../../widgets/show_plan_widget.dart';
import 'package:provider/provider.dart';

class RecentTripDetial extends StatefulWidget {
  String mainTitle;
  DateTime startDate;
  DateTime endDate;
  int duration;
  List<Days> lstOfDays;
  List<Trips> displayTrips = [];
  DateTime selectedDate;

  RecentTripDetial(
      
      {
        required this.selectedDate, 
        required this.startDate,
        required this.endDate,
        required this.duration,
        required this.mainTitle,
        required this.lstOfDays
      });
  @override
  State<RecentTripDetial> createState() => _RecentTripDetialState();
}

class _RecentTripDetialState extends State<RecentTripDetial> {
  void getListByDate(DateTime date) {
    try {
      setState(() {
        widget.selectedDate = date;
        widget.displayTrips = widget.lstOfDays
            .firstWhere((day) => DateUtils.isSameDay(date, day.date))
            .trips!;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StaggeredGrid.count(
            crossAxisCount: 1,
            mainAxisSpacing: 20,
            crossAxisSpacing: 1,
            children: [
              StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 20,
                  child: Column(
                    children: [

                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 40, 0.0),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back, size: 30),
                              onPressed: () {
                                Get.toNamed('/home');
                              },
                            ),
                          ),
                          Text('Title: ${widget.mainTitle}'),
                        ]),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                        child: DatePicker(
                          widget.startDate,
                          initialSelectedDate: widget.selectedDate,
                          selectionColor: Colors.black,
                          selectedTextColor: Colors.white,
                          daysCount: widget.duration+1,
                          onDateChange: (date) {
                            getListByDate(date);
                          },
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 303,
                          child: ShowPlanWidget(lst: widget.displayTrips))
                    ],
                  ))
            ]),
      ),
    );
  }
}
