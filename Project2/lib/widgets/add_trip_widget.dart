import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:travelling_app/provider/add_trip_provider.dart';
import 'package:provider/provider.dart';
import 'package:travelling_app/screens/Plan/plan_screen.dart';

class AddTripWidget extends StatefulWidget {
  const AddTripWidget({Key? key}) : super(key: key);

  @override
  State<AddTripWidget> createState() => _AddTripWidgetState();
}

class _AddTripWidgetState extends State<AddTripWidget> {
  TextEditingController title = TextEditingController();
  DateTimeRange? myDateRange;
  final _formKey = GlobalKey<FormState>();
  late final DateTime startDate;
  late final DateTime endDate;

  void _submitForm() {
    final FormState? form = _formKey.currentState;
    if (_formKey.currentState!.validate()) {
      form!.save();
    }
  }

  Future<void> addTripDialog() async {
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: ListView(children: [
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: TextFormField(
                              controller: title,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                                labelText: "Trip Title",
                                hintText: 'Enter your Trip Title',
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Enter Your Trip Title';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: DateRangeField(
                                enabled: true,
                                initialValue: DateTimeRange(
                                    start: DateTime.now(),
                                    end: DateTime.now().add(Duration(days: 5))),
                                decoration: InputDecoration(
                                  labelText: 'Date Range',
                                  prefixIcon: Icon(Icons.date_range),
                                  hintText:
                                      'Please select a start and end date',
                                  border: OutlineInputBorder(),
                                ),
                                // validator: (value) {
                                //   if (value!.start.isBefore(DateTime.now())) {
                                //     return 'Please enter a later start date';
                                //   }
                                //   return null;
                                // },
                                onSaved: (value) {
                                  setState(() {
                                    myDateRange = value!;
                                  });
                                }),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    child: Text('Submit'),
                                    onPressed: () { 
                                      _submitForm();

                                      final myDateRange = this.myDateRange;
                                      if (myDateRange != null) {
                                        Duration? dure = myDateRange.duration;
                                        startDate = myDateRange.start;

                                        print("Start: " + startDate.toString());
                                        print("Duration: " +
                                            dure!.inDays.toString());
                                        // print(
                                        //     "Saved value is: ${myDateRange.toString()} and  ${title.text}");

                                        // context
                                        //     .read<AddTripProvider>()
                                        //     .initInstancs(title.text, startDate,
                                        //         dure.inDays);

                                 
                                          Get.toNamed('/plan',  arguments: {
              "title": title.text,
              "startDate": startDate.toString(),
              "duration": dure.inDays.toString()
            } );
                             
                                      }
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
    var squareWidth = MediaQuery.of(context).size.width / 2 - 12;

    return InkWell(
      onTap: () {
        addTripDialog();
      },
      child: Container(
        width: squareWidth,
        height: squareWidth,
        child: DottedBorder(
          color: Colors.black,
          strokeWidth: 1,
          child: Center(
            child: Icon(
              Icons.add,
              size: 10,
            ),
          ),
        ),
      ),
    );
  }
}
