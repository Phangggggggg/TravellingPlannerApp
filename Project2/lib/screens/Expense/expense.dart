import 'package:flutter/material.dart';
import 'package:travelling_app/colors/colors.dart';
import '../../models/days.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

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

  int getHighestExpense(List<double> expenses) {
    double maxx = expenses.reduce(max);
    expenses.indexOf(maxx);
    return expenses.indexOf(maxx);
  }

  int getLowestExpense(List<double> expenses) {
    double minn = expenses.reduce(min);
    expenses.indexOf(minn);
    return expenses.indexOf(minn);
  }

  final format = DateFormat('yyyy-MM-dd');

  String formatDateMonth(DateTime date) {
    String now;
    try {
      now = DateFormat.MMM().format(date);
    } catch (e) {
      now = "";
    }

    return now;
  }

  String formatDateDay(DateTime date) {
    String now;
    try {
      now = DateFormat.d().format(date);
    } catch (e) {
      now = "";
    }

    return now;
  }


  List<PieChartSectionData> getSections() {
    List<PieChartSectionData> lst = [];
    double totalExpense = calTotalExpense(widget.totalExpenseByDay);
    for (var i = 0; i < widget.totalExpenseByDay.length; i++) {
      double weight =
        (widget.totalExpenseByDay[i] / totalExpense) * 360;
      double percent = (widget.totalExpenseByDay[i] / totalExpense) * 100;
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 15.0;
      final radius = isTouched ? 65.0 : 50.0;


      final color = (i + 1) % 2 == 0 ? kRajah : kDesire;
      PieChartSectionData pieChartData = PieChartSectionData(
        value: weight,
        title: 'Day ${i + 1}\n ${percent.ceil()}%',
        color: color,
        radius: radius,
        borderSide: BorderSide(
          color: kWheat,
          width: 1.0,
        ),
        titleStyle: TextStyle(fontSize: fontSize, color: kWheat),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30.0,
                  ),
                  Text(widget.title,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: kBrown)),
                  SizedBox(
                          width: 40,
                        )
                ],
              ),

              SizedBox(
                width: 10,
                height: 10,
              ),
              SizedBox(
                width: 400,
                height: 200,
                child: PieChart(
                  PieChartData(
                      centerSpaceRadius: 45.0,
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
                    
                      sections: getSections()),
                  swapAnimationDuration:
                      Duration(milliseconds: 150), // Optional
                  swapAnimationCurve: Curves.linear, // Optional
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                  text: 'Total: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kBrown, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            '${calTotalExpense(widget.totalExpenseByDay)} Baht',
                        style: TextStyle(
                          color: kBrown,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        )),
                  ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
                width: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    
                      height: 50,
                      width: 140,
                      decoration: BoxDecoration(
                          color: kRajah,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                            
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                          'Maximum spend ',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: kBrown)
                        ),
                        Text(
                          widget.totalExpenseByDay[
                                  getHighestExpense(widget.totalExpenseByDay)]
                              .toString() + ' Baht',
                          style: TextStyle(
                              fontSize: 12,
                              // fontWeight: FontWeight.bold,
                              color: kBrown)
                        ),
                        ],
                      )
                  ),
                  Container(
                      height: 50,
                      width: 140,
                      decoration: BoxDecoration(
                          color: kRajah,
                          borderRadius: BorderRadius.all(
                            Radius.circular(13),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                          'Minimux spend ',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: kBrown)
                        ),
                        Text(
                          widget.totalExpenseByDay[
                                  getLowestExpense(widget.totalExpenseByDay)]
                              .toString() + ' Baht' ,
                          style: TextStyle(
                              fontSize: 12,
                              // fontWeight: FontWeight.bold,
                              color: kBrown)
                        ),
                        ],
                      )
                  )
                ],    
              ),
              SizedBox(
                height: 10,
                width: 110,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 400,
                child: ListView.builder(
                    itemCount: widget.totalExpenseByDay.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        elevation: 0,
                        color: kWheat,
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: index % 2 == 0 ? kDesire : kRajah,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )),
                          child: ListTile(
                            // contentPadding: EdgeInsets.symmetric(
                            //     horizontal: 20.0, vertical: 10.0),
                            leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                      right: new BorderSide(
                                          width: 1.0,
                                          color: Colors.white24))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          formatDateDay(widget.startDate
                                              .add(Duration(days: index))),
                                          style: TextStyle(
                                              color: index % 2 == 0 ? kWheat: kBrown,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25)),
                                      Text(
                                          formatDateMonth(widget.startDate
                                              .add(Duration(days: index))),
                                          style: TextStyle(
                                              color: index % 2 == 0 ? kWheat: kBrown,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            title: Text(
                              "Day ${index + 1}",
                              style: TextStyle(
                                  color: index % 2 == 0 ? kWheat: kBrown,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
          
                            subtitle: Row(
                              children: <Widget>[
                                Icon(Icons.linear_scale,
                                    color: Colors.yellowAccent),
                                Text(
                                    " ${widget.totalExpenseByDay[index]} Baht",
                                    style: TextStyle(
                                        color: index % 2 == 0 ? kWheat: kBrown, fontSize: 15.5))
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
              ),
            ],
          )),
    );
  }
}
