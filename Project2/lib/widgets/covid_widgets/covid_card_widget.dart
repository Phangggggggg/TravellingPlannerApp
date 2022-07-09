import 'package:flutter/material.dart';
import 'package:travelling_app/colors/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'line_chart.dart';

class CovidCardWidget extends StatelessWidget {
  final String title;
  final String info;
  final Color iconColor;
  final IconData iconImage;
  CovidCardWidget(
      {required this.title,
      required this.info,
      required this.iconColor,
      required this.iconImage});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 80,
      decoration: BoxDecoration(
          color: kRed, borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 240, 197, 211),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0.0, 8),
                  child: Icon(iconImage),
                ),
                Flexible(
                    child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 2),
                    child: Text(
                      title,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(info, style: TextStyle(color: Colors.white, fontSize: 15)),
              ],
            ),
          )
          // Row(
          //   children: [
          //     Text(info),
          //     LineReportChart(),
          //   ],
          // ),
        ],
      ),
    );
  }
}
