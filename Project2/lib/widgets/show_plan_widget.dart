import 'package:flutter/material.dart';
import 'package:travelling_app/models/place_model.dart';
import 'package:travelling_app/models/trips.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:travelling_app/provider/add_trip_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:travelling_app/screens/Plan/show_place_detail.dart';
import '/colors/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShowPlanWidget extends StatelessWidget {
  List<Trips> lst;
  final bool isShowSlider;

  ShowPlanWidget({required this.lst, required this.isShowSlider});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: lst.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 15, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              // height: 240,
              child: Card(
                color: index % 2 == 0 ? kDesire : kRajah,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Slidable(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 5, 5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 5, 15),
                              child: Text(
                                lst[index].title,
                                style: TextStyle(fontWeight: FontWeight.bold, color: index % 2 == 0 ? kWheat : kBrown),
                              ),
                            ),
                          ],
                        ),
                        Row(children: [
                          Icon(Icons.place, color: index % 2 == 0 ? kWheat : kBrown),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 5, 15),
                              child: Container(
                                child: Text(
                                  lst[index].category.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(color: index % 2 == 0 ? kWheat : kBrown),
                                ),
                              ),
                            ),
                          )
                        ]),
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.clock, color: index % 2 == 0 ? kWheat : kBrown),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 5, 15),
                              child: Text(DateFormat.jm().format(
                                      DateFormat("hh:mm:ss").parse(
                                          lst[index].startTime.toString())) +
                                  ' - ' +
                                  DateFormat.jm().format(DateFormat("hh:mm:ss")
                                      .parse(lst[index].endTime.toString())), style: TextStyle(color: index % 2 == 0 ? kWheat : kBrown)),
                            ),
                          ],
                        ),
                        Row(children: [
                          Icon(Icons.description, color: index % 2 == 0 ? kWheat : kBrown),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 5, 15),
                            child: Text(
                              lst[index].description.toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: index % 2 == 0 ? kWheat : kBrown)
                            ),
                          ),
                        ]),
                        Row(children: [
                          Icon(Icons.money, color: index % 2 == 0 ? kWheat : kBrown),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 5, 15),
                            child:
                                Text(lst[index].expense.toString() + ' Baht', style: TextStyle(color: index % 2 == 0 ? kWheat : kBrown)),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  key: const ValueKey(0),
                  startActionPane:  ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),

                      // A pane can dismiss the Slidable.
                      // dismissible: DismissiblePane(onDismissed: () {}),

                      // All actions are defined in the children parameter.
                      children: [
                        // A SlidableAction can have an icon and/or a label.
                          if (isShowSlider) ...[

                        SlidableAction(
                          onPressed: (value) {
                            context
                                .read<AddTripProvider>()
                                .removeTripByDate(index);
                          },
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                                    ],
                        if (lst[index].placeModel != null) ...[
                          // ignore: avoid_print
                          SlidableAction(
                            onPressed: (value) {
                              PlaceModel pm = lst[index].placeModel!;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowPlaceDetail(
                                          isShow: false,
                                          placeModel: pm,
                                        )),
                              );
                            },
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            icon: FontAwesomeIcons.circleInfo,
                            label: 'Detail',
                          ),
                        ]
                      ]),
                ),
              ),
            ),
          );
        });
  }
}
