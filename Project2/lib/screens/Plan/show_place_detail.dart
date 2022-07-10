import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:travelling_app/colors/colors.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:intl/intl.dart';
import 'package:travelling_app/models/place_model.dart';
import '../../provider/add_trip_provider.dart';
import 'package:travelling_app/models/trips.dart';

class ShowPlaceDetail extends StatefulWidget {
  bool isShow;
  PlaceModel placeModel;

  ShowPlaceDetail({
    required this.placeModel,
    required this.isShow,
  });

  @override
  State<ShowPlaceDetail> createState() => _ShowPlaceDetailState();
}

class _ShowPlaceDetailState extends State<ShowPlaceDetail>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _formKey = GlobalKey<FormState>();
  TextEditingController todo = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController expences = TextEditingController();
  TextEditingController category = TextEditingController();
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
    startTime.text = "";
    endTime.text = "";
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _submitForm() {
    final FormState? form = _formKey.currentState;
    if (_formKey.currentState!.validate()) {
      form!.save();
    }
  }

  Future<void> addTripDialog(String place) async {
    await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text('Please filled in Your Trip info'),
              content: SingleChildScrollView(
                  child: Container(
                      height: 300,
                      width: double.maxFinite,
                      child: Form(
                        key: _formKey,
                        autovalidateMode: _autoValidate
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                        child: ListView(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: TextFormField(
                              controller: todo,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                                labelText: "Add what To Do",
                                hintText: 'Enter your To Do',
                                prefixIcon: Icon(
                                  Icons.list,
                                ),
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Enter your To Do';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            child: TextFormField(
                              controller: startTime,
                              decoration: InputDecoration(
                                icon: Icon(Icons.timer), //icon of text field
                                labelText: "Enter Start Time",
                              ),
                              readOnly: true,
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                );
                                if (pickedTime != null) {
                                  // print(pickedTime.format(context));
                                  DateTime parsedTime = DateFormat.jm().parse(
                                      pickedTime.format(context).toString());
                                  // print(parsedTime);
                                  String formattedTime =
                                      DateFormat('HH:mm:ss').format(parsedTime);
                                  // print(formattedTime);
                                  setState(() {
                                    startTime.text =
                                        formattedTime; //set the value of text field.
                                  });
                                } else {
                                  print("Time is not selected");
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
                            child: TextFormField(
                              controller: endTime,
                              decoration: InputDecoration(
                                icon: Icon(Icons.timer), //icon of text field
                                labelText: "Enter End Time",
                              ),
                              readOnly: true,
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                );
                                if (pickedTime != null) {
                                  // print(pickedTime.format(context));
                                  DateTime parsedTime = DateFormat.jm().parse(
                                      pickedTime.format(context).toString());
                                  // print(parsedTime);
                                  String formattedTime =
                                      DateFormat('HH:mm:ss').format(parsedTime);
                                  // print(formattedTime);
                                  setState(() {
                                    endTime.text =
                                        formattedTime; //set the value of text field.
                                  });
                                } else {
                                  print("Time is not selected");
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: discription,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 225, 224, 224),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                                labelText: "Description",
                                // errorText: _errText,
                                hintText: 'Enter the Description',
                                prefixIcon: Icon(
                                  Icons.description,
                                ),
                              ),
                              validator: (text) {
                                // print(text);
                                if (text == null || text.isEmpty) {
                                  return 'Enter the Description';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              controller: expences,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 225, 224, 224),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                                labelText: "Expense",
                                // errorText: _errText,
                                hintText: 'Enter your Expense',
                                prefixIcon: Icon(Icons.money_outlined),
                              ),
                              validator: (text) {
                                // print(text);
                                if (text == null || text.isEmpty) {
                                  return 'Enter your Expense';
                                }
                              },
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    child: Text('Submit'),
                                    onPressed: () {
                                      _submitForm();

                                      Trips trip = Trips(
                                          title: todo.text,
                                          description: discription.text,
                                          startTime: startTime.text,
                                          endTime: endTime.text,
                                          category: place,
                                          expense: expences.text,
                                          placeModel: widget.placeModel);

                                      context
                                          .read<AddTripProvider>()
                                          .addTripByDate(
                                              context.read<AddTripProvider>().selectedDay,
                                              trip);
                                      print('selectedDate: ${context
                                          .read<AddTripProvider>()
                                          .selectedDay}');
                                      Navigator.pop(context);

                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            Future.delayed(Duration(seconds: 1),
                                                () {
                                              Navigator.of(context).pop(true);
                                            });
                                            return AlertDialog(
                                              title: const Text('Confirmation'),
                                              content: const Text(
                                                  'Succesfully add the place into your plan'),
                                            );
                                          });
                                    }),
                                ElevatedButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              ])
                        ]),
                      )) //form
                  ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWheat,
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                        child: widget.placeModel.picUrl!.isEmpty ||
                                widget.placeModel.picUrl! == 'NULL'
                            ? Image.asset(
                                'lib/assets/logos/withbg.png',
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                widget.placeModel.picUrl!,
                                fit: BoxFit.cover,
                              )),
                    height: MediaQuery.of(context).size.width - 30,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ])), // container
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        iconSize: 30.0,
                        color: widget.placeModel.picUrl!.isEmpty ||
                                widget.placeModel.picUrl! == 'NULL'
                            ? kBrown
                            : Colors.white,
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 20.0,
                  bottom: 20.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.placeModel.district!,
                        maxLines: 2,
                        style: TextStyle(
                          color: widget.placeModel.picUrl!.isEmpty ||
                                  widget.placeModel.picUrl! == 'NULL'
                              ? kBrown
                              : Colors.white,
                          fontSize: 32.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.locationArrow,
                            size: 15.0,
                            color: widget.placeModel.picUrl!.isEmpty ||
                                    widget.placeModel.picUrl! == 'NULL'
                                ? kRed
                                : Colors.white,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            widget.placeModel.province!,
                            style: TextStyle(
                                color: widget.placeModel.picUrl!.isEmpty ||
                                        widget.placeModel.picUrl! == 'NULL'
                                    ? kBrown
                                    : Colors.white,
                                fontSize: 20.0),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),

            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  if (widget.placeModel.placeName!.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                      child: Text(
                        widget.placeModel.placeName!,
                        style: TextStyle(
                          color: kRed,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                  if (widget.placeModel.shaTypeDescription!.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Text(
                        widget.placeModel.shaTypeDescription!,
                        style: TextStyle(
                          color: kBrown,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          // letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                  Divider(
                    color: Colors.grey,
                    height: 10,
                    thickness: 1,
                    indent: 15,
                    endIndent: 15,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 10, 0.0, 0),
                        child: Icon(
                          FontAwesomeIcons.locationDot,
                          size: 15.0,
                          color: kRed,
                        ),
                      ),
                      if (widget.placeModel.district!.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(13, 10, 0.0, 0),
                          child: Text(
                            widget.placeModel.district!,
                            style: TextStyle(
                              color: kBrown,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w300,
                              // letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (widget.placeModel.address!.isNotEmpty) ...[
                    // Flexible(
                    //   child: Container(
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 0, 0.0, 0),
                      child: Text(
                        widget.placeModel.address!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: kBrown,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          // letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                  if (widget.placeModel.subDistrict!.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 0, 0.0, 0),
                      child: Text(
                        widget.placeModel.subDistrict!,
                        style: TextStyle(
                          color: kBrown,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          // letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                  if (widget.placeModel.postcode!.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 0, 0.0, 0),
                      child: Text(
                        widget.placeModel.postcode!,
                        style: TextStyle(
                          color: kBrown,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          // letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                  if (widget.placeModel.phones!.isNotEmpty) ...[
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            FontAwesomeIcons.phone,
                            size: 15.0,
                            color: kRed,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.placeModel.phones!,
                            style: TextStyle(
                              color: kBrown,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w300,
                              // letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  Divider(
                    color: Colors.grey,
                    height: 30,
                    thickness: 1,
                    indent: 15,
                    endIndent: 15,
                  ),
                  if (widget.placeModel.detial!.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.placeModel.detial!,
                        style: TextStyle(
                          color: kBrown,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          // letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ], //children
              ),
            )), //expand;
          ],
        ),
        floatingActionButton: widget.isShow
            ? FloatingActionButton.extended(
                onPressed: () {
                  addTripDialog(widget.placeModel.placeName!);

                  // Add your onPressed code here!
                },
                label: const Text('Add to Plan'),
                icon: const Icon(Icons.add),
                backgroundColor: kRed,
              )
            : null,
      ), //stack
    );
  }
}
