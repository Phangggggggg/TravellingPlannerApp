import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelling_app/api/get_url.dart';
import 'package:basic_utils/basic_utils.dart';

class GetPlace {
  Future<void> getAPlace(String keyword, String geolocation, String provincename) async {
    // Map<String, String> queryParams = {
    //   'keyword': keyword,
    //   'location': geolocation
    // };

    final queryParams = Uri.encodeQueryComponent(jsonEncode({
      "keyword": keyword,
      "location": geolocation,
      "provinceName": provincename,
    }));
    //https://tatapi.tourismthailand.org/tatapi/v5/places/search?keyword=อาหาร&location=13.6904831,100.5226014&categorycodes=RESTAURANT&provinceName=Bangkok&radius=20&numberOfResult=10&pagenumber=1&destination=Bangkok&filterByUpdateDate=2019/09/01-2021/12/31
    try {
      var uri1 = 'https://tatapi.tourismthailand.org/tatapi/v5/places/search?' +
          'keyword=${keyword}' +
          "&" +
          'location=${geolocation}' + '&' + 'provinceName=${provincename}';
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
    } catch (e) {
      print(e);
    }
  }
}
