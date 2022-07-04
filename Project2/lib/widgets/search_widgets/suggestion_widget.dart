import 'package:flutter/material.dart';
import 'package:travelling_app/models/trips.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:travelling_app/provider/add_trip_provider.dart';
import 'package:provider/provider.dart';

class SuggestionWidget extends StatelessWidget {

    const SuggestionWidget({Key? key}) : super(key: key);
  
//   List<Trips> lst;
  

  @override
  Widget build(BuildContext context) {

    return 
         ListView.builder(
            scrollDirection: Axis.vertical,
            // itemCount: lst.length,
            itemBuilder: (context, index) {
              return Card(
                
                child: Column(
                    children: [
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
