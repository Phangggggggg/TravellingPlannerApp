//https://tatapi.tourismthailand.org/tatapi/v5/places/search
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelling_app/api/get_url.dart';
import 'package:basic_utils/basic_utils.dart';

class GetResturant {
  Future<void> getAResDetail(String place_id) async {
   
    var uri1 = 'https://tatapi.tourismthailand.org/tatapi/v5/restaurant/${place_id}'; 

    var res = await http.get(
      Uri.parse(uri1),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer ${GetUrl.tat}',
        'Accept-Language': 'en'
      },
    );
    print(res.statusCode);
    print(res.body);
  }
}
