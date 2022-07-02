import 'package:http/http.dart' as http;
import 'package:basic_utils/basic_utils.dart';
import 'package:travelling_app/api/get_url.dart';

class GetCovid {
  static const String covidUrl =
      'https://covid19.ddc.moph.go.th/api/Cases/today-cases-all';
  Future<void> getCovidDialy() async {
    try {
      var res = await http.get(Uri.parse(covidUrl), headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      });
      print(res.body);
    } catch (e) {
      print(e);
    }
  }
}
