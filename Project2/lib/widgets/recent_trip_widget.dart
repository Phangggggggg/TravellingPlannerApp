import 'package:flutter/material.dart';
import 'package:travelling_app/provider/add_trip_provider.dart';
import 'package:travelling_app/widgets/trip_widget.dart';
import '../models/main_trip_model.dart';
import '/widgets/show_plan_widget.dart';
import '/screens/Home/RecentTrip/recent_trip_detail.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            child: ListView.builder(
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
                        color: Color.fromARGB(255, 219, 196, 125),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Spacer(flex: 20),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 0.0, 90, 0.0),
                                  child: Icon(
                                    Icons.task,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.close_rounded,
                                    color: Colors.black,
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
                              ],
                            ),
                            TripWidget(
                                mainTitle: widget.lst[index].mainTitle,
                                startDate: widget.lst[index].stratDate,
                                endDate: widget.lst[index].endDate,
                                duration: findDiff(DateTime.parse(widget.lst[index].stratDate),DateTime.parse(widget.lst[index].endDate))),
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
