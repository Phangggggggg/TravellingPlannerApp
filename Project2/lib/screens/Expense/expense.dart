import 'package:flutter/material.dart';
import '../../models/days.dart';
import 'package:intl/intl.dart';

class Expense extends StatelessWidget {
  final List<double> totalExpenseByDay;
  final DateTime startDate;
  final DateTime endDate;
  final String title;
  Expense(
      {required this.totalExpenseByDay,
      required this.startDate,
      required this.endDate,
      required this.title});

  final format = DateFormat('yyyy-MM-dd');

  String formatDate(DateTime date) {
    String now;
    try {
      now = DateFormat.yMMMd().format(date);
    } catch (e) {
      now = "";
    }

    return now;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Column(
        children: [

          IconButton( 
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            iconSize: 30.0, 
          ),
          
          Expanded(
            child: ListView.builder(
              itemCount: totalExpenseByDay.length,
              itemBuilder: ((context, index) {
              return Text('Day${index+1} ${totalExpenseByDay[index]}');
            })),
          ),
        ],
      )),
    );
  }
}
