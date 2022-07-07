import 'package:flutter/material.dart';
import 'package:travelling_app/widgets/trip_widget.dart';
import '../models/main_trip_model.dart';
import '/widgets/show_plan_widget.dart';
import '/screens/Home/RecentTrip/recent_trip_detail.dart';
import 'package:get/get.dart';
class RecentTripWidget extends StatelessWidget {
  List<MainTripModel> lst;

  RecentTripWidget({required this.lst});

  @override
  Widget build(BuildContext context) {
    // print(lst.length);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: lst.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  DateTime startDate = DateTime.parse(lst[index].stratDate);
                  DateTime endDate = DateTime.parse(lst[index].endDate);

                  var difference = endDate.difference(startDate).inDays;

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  RecentTripDetial(selectedDate: startDate,startDate: startDate,endDate: endDate, duration: difference, lstOfDays: lst[index].listOfDays,mainTitle: lst[index].mainTitle)),
                  );
                },
                child: Card(
                  child: Column(
                    children: [
                      TripWidget(
                          mainTitle: lst[index].mainTitle,
                          startDate: lst[index].stratDate,
                          endDate: lst[index].endDate),
                      SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                ));
          }),
    );
  }
}
