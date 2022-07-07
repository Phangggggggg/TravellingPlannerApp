import 'package:flutter/material.dart';
import 'package:travelling_app/models/place_model.dart';
import 'package:travelling_app/models/trips.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SuggestionWidget extends StatelessWidget {

//   List<Trips> lst;
  List<PlaceModel> lst;

  SuggestionWidget({required this.lst});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: lst.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: '+lst[index].placeName.toString()),
                 Text('Address: '+lst[index].address.toString()),
                  Text('District: '+lst[index].district.toString()),
                  // Text(lst[index].introduction.toString())


                // Text(lst[index].title),
                // Text(lst[index].startTime.toString()),
                // Text(lst[index].endTime.toString()),
                // Text(lst[index].description.toString()),
                // Text(lst[index].expense.toString()),
                // Text(lst[index].category.toString()),
              ],
            ),
          );
        });
  }
}
