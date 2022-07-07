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
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                          children: [
                          Row(
                            children: [
                              Icon(Icons.title, color: Colors.black),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text('Title: '+ lst[index].title),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.time_to_leave, color: Colors.black),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text('Start time:'  + lst[index].startTime.toString()),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                            Icon(Icons.punch_clock, color: Colors.black),
                            Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text('End Time: '+lst[index].endTime.toString()),
                            
                            ),
                            ]
                          ),
                          Row(
                            children: [
                            Icon(Icons.description, color: Colors.black),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text('Description: '+lst[index].description.toString()),
                          ),
                            ]),
                            Row(
                            children: [
                               Icon(Icons.money, color: Colors.black),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text('Expense: '+lst[index].expense.toString()),
                            ),
                            ]
                          ),
                          Row(
                            children: [
                              Icon(Icons.category, color: Colors.black),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text('Categoty: '+lst[index].category.toString()),
                              ),
                            ]), 
                          ],
                      ),
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
