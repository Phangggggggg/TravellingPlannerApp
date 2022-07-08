import 'package:flutter/material.dart';
import 'package:travelling_app/models/trips.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:travelling_app/provider/add_trip_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


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
              return Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 20, 8),
                child: SizedBox(
                   width: MediaQuery.of(context).size.width/2,
                    height: 200,
                  child: Card(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    ),
                    child: Slidable(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 5, 5),
                          child: Column(
                              children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                                    child: Text(lst[index].title, style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.time_to_leave, color: Colors.black),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),

                                    child:
                                    Text(DateFormat.jm().format(DateFormat("hh:mm:ss").parse(lst[index].startTime.toString())) + ' - '+ DateFormat.jm().format(DateFormat("hh:mm:ss").parse(lst[index].endTime.toString()))),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                  Icon(Icons.description, color: Colors.black),
                                  Flexible(child: Text(lst[index].description.toString(), maxLines: 3, overflow: TextOverflow.ellipsis,)),
                                  ]),
                              ),
                                Row(
                                children: [
                                   Icon(Icons.money, color: Colors.black),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 5, 5, 15),
                                  child: Text(lst[index].expense.toString() + ' Baht'),
                                ),
                                ]
                              ),
                              Row(
                                children: [
                                  Icon(Icons.category, color: Colors.black),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(lst[index].category.toString()),
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
                        
                    ),
                ),
              ); 
            });
      }
}
