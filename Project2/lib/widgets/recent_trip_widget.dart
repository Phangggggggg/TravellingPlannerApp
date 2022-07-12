import 'package:flutter/material.dart';
import 'package:travelling_app/provider/add_trip_provider.dart';
import '../models/main_trip_model.dart';
import '/widgets/show_plan_widget.dart';
import '/screens/Home/RecentTrip/recent_trip_detail.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import '/colors/colors.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecentTripWidget extends StatefulWidget {
  List<MainTripModel> lst;

  RecentTripWidget({required this.lst});

  @override
  State<RecentTripWidget> createState() => _RecentTripWidgetState();
}

class _RecentTripWidgetState extends State<RecentTripWidget> {
  int difference = 0;
  late FirebaseFirestore _firestore;

  void iniFirebase() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
  }

  int findDiff(DateTime startDate, DateTime endDate) {
    var difference = endDate.difference(startDate).inDays;
    return difference;
  }

  @override
  void initState() {
    super.initState();
    iniFirebase();
  }

  @override
  Widget build(BuildContext context) {
    // print(lst.length);

    return widget.lst.isEmpty
        ? Text('')
        : Container(
            // width: 800 ,
            height: MediaQuery.of(context).size.width/2 + 45,
            
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 800),
              child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(0, 0, 80, 0),
            
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.lst.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          DateTime startDate =
                              DateTime.parse(widget.lst[index].stratDate);
                          DateTime endDate =
                              DateTime.parse(widget.lst[index].endDate);
            
                          int difference = findDiff(startDate, endDate);
            
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecentTripDetial(
                                    selectedDate: startDate,
                                    startDate: startDate,
                                    endDate: endDate,
                                    duration: difference,
                                    lstOfDays: widget.lst[index].listOfDays,
                                    mainTitle: widget.lst[index].mainTitle)),
                          );
                        },
                        child: Card(
                          
                          elevation: 4.0,
                          color: kWheat,
          
                          child: Column(
            
                            crossAxisAlignment: CrossAxisAlignment.start,
                
                            children: [
            
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [ 
                                  Container(height: 8, width: MediaQuery.of(context).size.width/5 + 10, 
                                  color: index % 2 == 0 ? kDesire : kRajah,
                                      
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(50, 0, 0, 0.0),
                                  child: IconButton(
                                        icon: Icon(
                                          Icons.close_rounded,
                                          color: kBrown,
                                          size: 20,
                                        ),
                                        onPressed: () async {
                                          await _firestore
                                              .collection("travelTracker")
                                              .doc(widget.lst[index].docId)
                                              .delete()
                                              .then(
                                                (doc) => print("Document deleted"),
                                                onError: (e) => print(
                                                    "Error updating document $e"),
                                              );
                             
                                          await Navigator.popAndPushNamed(
                                              context, '/home');
                                        },
                                      ),
                                ),]),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 90, 8),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  
                                  children: [
                                    // Spacer(flex: 20),
                                  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                        FaIcon(FontAwesomeIcons.suitcaseRolling, color: kBrown),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            widget.lst[index].mainTitle,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold, color: kBrown, fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                                      
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text( 'From '+
                                  DateFormat.yMMMd().format(DateTime.parse(widget.lst[index].stratDate)),
                                  style: TextStyle(color: kBrown),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text( 'To ' + DateFormat.yMMMd().format(DateTime.parse(widget.lst[index].endDate)),
                                    style: TextStyle(color:kBrown)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(findDiff(DateTime.parse(widget.lst[index].stratDate),DateTime.parse(widget.lst[index].endDate)).toString() + ' Days', style: TextStyle(color: kBrown)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ));
                  }),
            ),
          );
  }
}
