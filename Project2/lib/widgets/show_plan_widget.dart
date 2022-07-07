import 'package:flutter/material.dart';
import 'package:travelling_app/models/trips.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:travelling_app/provider/add_trip_provider.dart';
import 'package:provider/provider.dart';

class ShowPlanWidget extends StatelessWidget {
  
  List<Trips> lst;
  
  ShowPlanWidget(
      {required this.lst});


  @override
  Widget build(BuildContext context) {

    return 
         ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: lst.length,
            itemBuilder: (context, index) {
              return Card(
                
                child: Slidable(
                    child: Column(
                        children: [
                        Text(lst[index].title),
                        Text(lst[index].startTime.toString()),
                        Text(lst[index].endTime.toString()),
                        Text(lst[index].description.toString()),
                        Text(lst[index].expense.toString()),
                        Text(lst[index].category.toString()),
                        ],
                    ),
                    
                    key: const ValueKey(0),

                    startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    // dismissible: DismissiblePane(onDismissed: () {}),

                    // All actions are defined in the children parameter.
                    children: [
                    // A SlidableAction can have an icon and/or a label.
                    SlidableAction(
                        
                        onPressed: (value) {   
                         context.read<AddTripProvider>().removeTripByDate(index);
                        },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 0.0),
                        // spacing: 10.0,
                     
                        
                    ),
                    ]               
                    )
                    ),
                    
                ); 
            });
      }
}
