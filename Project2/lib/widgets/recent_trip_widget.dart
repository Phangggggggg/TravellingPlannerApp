import 'package:flutter/material.dart';
import 'package:travelling_app/widgets/trip_widget.dart';

class RecentTripWidget extends StatelessWidget {
  const RecentTripWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
         itemCount: 6,
         itemBuilder: (context, index) {
        return Row(
          children: [
            TripWidget(),
              SizedBox(width: 5,)
          ],
        );
      }),
    );
  }
}
