import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelling_app/api/get_url.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:travelling_app/models/place_model.dart';

class GetPlace {
  Future<List<String>> getAPlace(String keyword, String geolocation,
      String provincename, String categorycodes) async {
    final queryParams = Uri.encodeQueryComponent(jsonEncode({
      "keyword": keyword,
      "location": geolocation,
      "provinceName": provincename,
      "categorycodes": categorycodes,
    }));
    List<String> ans = [];
    try {
      var uri1 = 'https://tatapi.tourismthailand.org/tatapi/v5/places/search?' +
          'keyword=${keyword}' +
          "&" +
          'location=${geolocation}' +
          '&' +
          'categorycodes=${categorycodes}'
              '&' +
          'provinceName=${provincename}';
      var res = await http.get(
        Uri.parse(uri1),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer ${GetUrl.tat}',
          'Accept-Language': 'en'
        },
      );
      if (res.statusCode != 200) {
        throw Exception('Failed to fetch get place data');
      }
      final data = json.decode(res.body);
      var listOfResult = data['result'].toList();
      listOfResult.forEach((model) {
        ans.add(model['place_id']);
      });
      return ans ;
    } catch (e) {
      print(e);
    }
    return ans;
  }
}
