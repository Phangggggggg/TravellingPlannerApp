import 'package:flutter/material.dart';
import 'package:travelling_app/colors/colors.dart';
import '../../models/days.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class Expense extends StatefulWidget {
  final List<double> totalExpenseByDay;
  final DateTime startDate;
  final DateTime endDate;
  final String title;
  Expense(
      {required this.totalExpenseByDay,
      required this.startDate,
      required this.endDate,
      required this.title});
  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  int touchedIndex = -1;

  final format = DateFormat('yyyy-MM-dd');

  String formatDate(DateTime date) {
    String now;
    try {
      now = DateFormat.MMMd().format(date);
    } catch (e) {
      now = "";
    }

    return now;
  }

  List<PieChartSectionData> getSections() {
    List<PieChartSectionData> lst = [];
    double totalExpense = calTotalExpense(widget.totalExpenseByDay);
    for (var i = 0; i < widget.totalExpenseByDay.length; i++) {
      double weight = widget.totalExpenseByDay[i] != 0
          ? (widget.totalExpenseByDay[i] / totalExpense) * 360
          : 10;
      double percent =   (widget.totalExpenseByDay[i] / totalExpense) * 100;
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 7.0 : 50.0;
      final color = (i + 1) % 2 == 0 ? Colors.red :  kBrown ;
      PieChartSectionData pieChartData = PieChartSectionData(
        value: weight,
        title: 'Day ${i + 1}\n ${percent.ceil()}%',
        color: color,
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.bold, color: kWheat),
      );
      lst.add(pieChartData);
    }

    return lst;
  }

  double calTotalExpense(List<double> list) {
    return list.fold(0, (previous, current) => previous + current);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: kWheat,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     IconButton(
                           onPressed: () {
                             Navigator.pop(context);
                           },
                           icon: Icon(Icons.arrow_back),
                           iconSize: 30.0,
                     ),
                   ],
                 ),
              SizedBox(
                width: 300,
                height: 300,
                child: PieChart(
                  PieChartData(
                      sectionsSpace: 0,
                      pieTouchData: PieTouchData(touchCallback:
                          (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                      
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      centerSpaceRadius: double.infinity,
                      sections: getSections()),
                  swapAnimationDuration:
                      Duration(milliseconds: 150), // Optional
                  swapAnimationCurve: Curves.linear, // Optional
                ),
              ),
           
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.title,
                      style: TextStyle(
                        fontSize: 15,
                      )),
                  // Text('Total: ${calTotalExpense(totalExpenseByDay)}'),
                  Flexible(
                      child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: 'Total: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kBrown,
                          fontSize: 15),
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                '${calTotalExpense(widget.totalExpenseByDay)} Baht',
                            style: TextStyle(
                              color: kBrown,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            )),
                      ],
                    ),
                  ))
                ],
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: ListView.builder(
                      itemCount: widget.totalExpenseByDay.length,
                      itemBuilder: ((context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: Container(
                            decoration: BoxDecoration(color: kRed),
                            child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: EdgeInsets.only(right: 12.0),
                                  decoration: new BoxDecoration(
                                      border: new Border(
                                          right: new BorderSide(
                                              width: 1.0,
                                              color: Colors.white24))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          formatDate(widget.startDate
                                              .add(Duration(days: index))),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                title: Text(
                                  "Day ${index + 1}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                subtitle: Row(
                                  children: <Widget>[
                                    Icon(Icons.linear_scale,
                                        color: Colors.yellowAccent),
                                    Text(
                                        " ${widget.totalExpenseByDay[index]} Baht",
                                        style: TextStyle(color: Colors.white))
                                  ],
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right,
                                    color: Colors.white, size: 30.0)),
                          ),
                        );
                      })),
                ),
              ),
            ],
          )),
    );
  }
}
