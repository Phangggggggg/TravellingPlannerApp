import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travelling_app/colors/colors.dart';
import 'package:travelling_app/models/trips.dart';
import 'package:travelling_app/screens/Plan/plan_screen.dart';
import '../../provider/add_trip_provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AddPlanInfoScreen extends StatefulWidget {
  late DateTime selectedDate;
  AddPlanInfoScreen({required this.selectedDate});
  @override
  State<AddPlanInfoScreen> createState() => _AddPlanInfoScreenState();
}

class _AddPlanInfoScreenState extends State<AddPlanInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController todo = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController expences = TextEditingController();
  TextEditingController category = TextEditingController();
  bool _autoValidate = false;

  void _submitForm() {
    final FormState? form = _formKey.currentState;
    if (_formKey.currentState!.validate()) {
      form!.save();
    }
  }

  @override
  void initState() {
    startTime.text = "";
    endTime.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StaggeredGrid.count(
            crossAxisCount: 1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 1,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(85, 20, 0.0, 0.0),
                child: Text('Add Your Trip Detail',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: kBrown)),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 10,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                      key: _formKey,
                      autovalidateMode: _autoValidate
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      child: ListView(children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: todo,
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
                              labelText: "Add what To Do",
                              // errorText: _errText,
                              hintText: 'Enter your To Do',
                              prefixIcon: Icon(
                                Icons.list,
                              ),
                            ),
                            validator: (text) {
                              // print(text);
                              if (text == null || text.isEmpty) {
                                return 'Enter your To Do';
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                          padding: const EdgeInsets.all(8.0),
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
                          padding: const EdgeInsets.all(5.0),
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
                              labelText: "Discription",
                              // errorText: _errText,
                              hintText: 'Enter the Discription',
                              prefixIcon: Icon(
                                Icons.description,
                              ),
                            ),
                            validator: (text) {
                              // print(text);
                              if (text == null || text.isEmpty) {
                                return 'Enter the Discription';
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
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: category,
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
                              labelText: "Place",
                              // errorText: _errText,
                              hintText: 'Enter the Place',
                              prefixIcon: Icon(
                                Icons.place,
                              ),
                            ),
                            validator: (text) {
                              // print(text);
                              if (text == null || text.isEmpty) {
                                return 'Enter the Place';
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(kRed),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(color: kRed))),
                            ),
                            onPressed: () {
                              _submitForm();
                              // "Saved value is: ${todo.text}, ${startTime.text}, ${endTime.text},  ${category.text}, ${expences.text}, ${discription.text}");
                              Trips trip = Trips(
                                  title: todo.text,
                                  description: discription.text,
                                  startTime: startTime.text,
                                  endTime: endTime.text,
                                  category: category.text,
                                  expense: expences.text);
                              context
                                  .read<AddTripProvider>()
                                  .addTripByDate(widget.selectedDate, trip);
                              Get.toNamed('/plan');
                            },
                            child: Text('Submit'))
                      ])),
                ),
              ),
            ]),
      ),
    );
  }
}
