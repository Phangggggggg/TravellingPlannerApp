import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../models/days.dart';
import '../../../models/trips.dart';
import '../../../widgets/show_plan_widget.dart';
import 'package:provider/provider.dart';
import '/colors/colors.dart';
import 'package:get/get.dart';
import '/screens/Expense/expense.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class RecentTripDetial extends StatefulWidget {
  String mainTitle;
  DateTime startDate;
  DateTime endDate;
  int duration;
  List<Days> lstOfDays;
  List<Trips> displayTrips = [];
  DateTime selectedDate;

  RecentTripDetial(
      {required this.selectedDate,
      required this.startDate,
      required this.endDate,
      required this.duration,
      required this.mainTitle,
      required this.lstOfDays});
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

  List<double> calExpense(List<Days> listOfDays) {
    List<double> totalExpenseByDay = [];
    listOfDays.forEach((element) {
      double totalExpense = 0.0;
      for (var i = 0; i < element.trips!.length; i++) {
        totalExpense += double.parse(element.trips![i].expense!);
      }
      totalExpenseByDay.add(totalExpense);
    });
    return totalExpenseByDay;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            List<double> expenses = calExpense(widget.lstOfDays);
            // print(expenses);

            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Expense(
                  totalExpenseByDay: expenses,
                  startDate: widget.startDate,
                  endDate: widget.endDate,
                  title: widget.mainTitle,
                );
              },
            ));
          },
          label: const Text('Expense Detail'),
          icon:FaIcon(FontAwesomeIcons.fileInvoiceDollar),
          backgroundColor: kDesire,
        ),
        body: StaggeredGrid.count(
            crossAxisCount: 1,
            mainAxisSpacing: 20,
            crossAxisSpacing: 1,
            children: [
              StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                       IconButton(
                              icon: Icon(Icons.arrow_back, size: 30),
                              onPressed: () {
                                Get.toNamed('/home');
                              },
                            ),
                        Text("${widget.mainTitle}", style: TextStyle(
                          fontSize: 30, 
                          color: kBrown,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                        SizedBox(
                          width: 40,
                        )
                       
                      ]),
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5.0, 0.0, 0.0),
                        child: DatePicker(
                          widget.startDate,
                          initialSelectedDate: widget.selectedDate,
                          selectionColor: kRajah,
                          selectedTextColor: Colors.white,
                          daysCount: widget.duration + 1,
                          onDateChange: (date) {
                            getListByDate(date);
                          },
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: ShowPlanWidget(lst: widget.displayTrips, isShowSlider: false,))
                    ],
                  ))
            ]),
      ),
    );
  }
}
