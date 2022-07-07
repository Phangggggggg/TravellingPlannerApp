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
  late FirebaseFirestore _firestore;

  void iniFirebase() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
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
            height: MediaQuery.of(context).size.height / 2,
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

                        var difference = endDate.difference(startDate).inDays;

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
                        child: Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_circle_left_sharp,
                                color: Colors.black,
                                size: 40,
                              ),
                              onPressed: () {
                                _firestore
                                    .collection("travelTracker")
                                    .doc(widget.lst[index].docId)
                                    .delete()
                                    .then(
                                      (doc) => print("Document deleted"),
                                      onError: (e) =>
                                          print("Error updating document $e"),
                                    );
                                // Provider.of<AddTripProvider>(context)
                                //     .setIsRebuild(true);

                                setState(() {
                                  widget.lst.removeWhere((element) =>
                                      element.docId == widget.lst[index].docId);

                                });
                              },
                            ),
                            TripWidget(
                                mainTitle: widget.lst[index].mainTitle,
                                startDate: widget.lst[index].stratDate,
                                endDate: widget.lst[index].endDate),
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
