import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travelling_app/api/get_latlong.dart';



class ProvinceSearchWidget extends StatefulWidget {
  String province;
  String city;

  ProvinceSearchWidget({
    required this.province,
    required this.city,
  });

  @override
  State<ProvinceSearchWidget> createState() => _ProvinceSearchWidgetState();
}

class _ProvinceSearchWidgetState extends State<ProvinceSearchWidget> {
  
    // String lat = data['results'][0]['geoPosition']['latitude'].toString();
    // String long = data['results'][0]['geoPosition']['longitude'].toString();
    // String provinceName = data['results'][0]['adminName1'];
    // print(provinceName);
    // print(lat);
    // print(long);
    // GetPlace getPlace = GetPlace();
    // getPlace.getAPlace('RESTAURANT', lat + ',' + long, provinceName);

  late Future<Map<String, dynamic>> futureData;

  GetLatLong getLatLong = GetLatLong(); 

  @override
  void initState() {
    super.initState();
    // futureData = fetchData(); // Here you have the data that you need
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextButton(
        child: Text('here'),
        onPressed: () {
          // getLatLong.fetchData('Bangkok',"Taling Chan");
        },
      ),
    ));
  }
}
