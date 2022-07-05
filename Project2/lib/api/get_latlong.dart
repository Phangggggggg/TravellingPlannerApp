import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetLatLong {

  Future<void> fetchData(String province, String city) async {
    final where = Uri.encodeQueryComponent(jsonEncode({
      "adminName1": province,
      "placeName": city,
    }));

    final response = await http.get(
        Uri.parse(
            'https://parseapi.back4app.com/classes/TH?limit=10&where=$where'),
        headers: {
          "X-Parse-Application-Id":
              "zS2XAEVEZAkD081UmEECFq22mAjIvX2IlTYaQfai", // This is the fake app's application id
          "X-Parse-Master-Key":
              "t6EjVCUOwutr1ruorlXNsH3Rz65g0jiVtbILtAYU" // This is the fake app's readonly master key
        });
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch data');
    }
    final data = json.decode(response.body);
  }
}
