import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:provider/provider.dart';
import 'package:travelling_app/colors/colors.dart';
import '../../provider/add_trip_provider.dart';

class SearchBarWidget extends StatefulWidget {
  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  String address = "";
  GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<AddTripProvider>(
        builder: (context, addTripProvider, child) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ///Adding CSC Picker Widget in app
              CSCPicker(
                ///Enable disable state dropdown [OPTIONAL PARAMETER]
                showStates: true,

                /// Enable disable city drop down [OPTIONAL PARAMETER]
                showCities: true,

                ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                flagState: CountryFlag.DISABLE,

                ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 1)),

                ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                disabledDropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.grey.shade300, width: 1)),

                ///placeholders for dropdown search field
                countrySearchPlaceholder: "Country",
                stateSearchPlaceholder: "Province",
                citySearchPlaceholder: "City",
                disableCountry: true,

                ///labels for dropdown
                countryDropdownLabel: "*Country",
                stateDropdownLabel: "Province",
                cityDropdownLabel: "City",

                ///Default Country
                defaultCountry: DefaultCountry.Thailand,
                

                ///Disable country dropdown (Note: use it with default country)
                //disableCountry: true,

                ///selected item style [OPTIONAL PARAMETER]
                selectedItemStyle: TextStyle(
                  color: kBrown,
                  fontSize: 14,
                ),

                ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                dropdownHeadingStyle: TextStyle(
                    color: kBrown,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),

                ///DropdownDialog Item style [OPTIONAL PARAMETER]
                dropdownItemStyle: TextStyle(
                  color: kBrown,
                  fontSize: 14,
                ),

                ///Dialog box radius [OPTIONAL PARAMETER]
                dropdownDialogRadius: 10.0,

                ///Search bar radius [OPTIONAL PARAMETER]
                searchBarRadius: 10.0,

                ///triggers once country selected in dropdown
                onCountryChanged: (value) {},

                ///triggers once state selected in dropdown
                onStateChanged: (value) {
                  addTripProvider.setProvince(value);
                },

                ///triggers once city selected in dropdown
                onCityChanged: (value) {
                  addTripProvider.setCity(value);
                },
              ),

              SizedBox(
                height: 10, // <-- match_parent

              ),

              ///print newly selected country state and city in Text Widget
              SizedBox(
                width: 300, // <-- match_parent
                height: 40, 
                child: ElevatedButton(
                    style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                      backgroundColor: MaterialStateProperty.all<Color>(kRed),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                          side: BorderSide(color: kRed)
                                        )
                                      ),
                                    ),

                    onPressed: () async {
    
                      if (addTripProvider.count != 0) {
                        await addTripProvider.fetchLatLong(
                            addTripProvider.stateValue!,
                            addTripProvider.cityValue!);
                        await addTripProvider
                            .getAll(addTripProvider.userLatitude,
                                addTripProvider.userLongtitude)
                            .whenComplete(() {
                          addTripProvider.setIsDoneSearch(true);
                        });
                      } else {
                        await addTripProvider.getAll('13', '100');
                      }
                    },
                    child: Text("Search")),
              ),
            ],
          ),
        ),
      );
    });
  }
}
