import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:travelling_app/models/covid_model.dart';
import '../api/get_url.dart';
import 'dart:convert';

class CovidProvider extends ChangeNotifier {
  // late CovidModel _covidModel;

  // CovidModel get covidModel => _covidModel;
  static const String covidUrl =
      'https://covid19.ddc.moph.go.th/api/Cases/today-cases-all';
  Future<CovidModel> getCovidDialy() async {
    print('heere');
    try {
      var res = await http.get(Uri.parse(covidUrl), headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      });
      if (res.statusCode != 200) {
        throw Exception('Failed to fetch covid data');
      }
      final data = json.decode(res.body)[0];

      final CovidModel covidModel = CovidModel(
          txnDate: data['txn_date'],
          newCase: data['new_case'],
          totalCase: data['total_case'],
          newCaseExAbroad: data['new_case_excludeabroad'],
          totalCaseExAbroad: data['total_case_excludeabroad'],
          newDeath: data['new_death'],
          totalDeath: data['total_death'],
          newRecvoered: data['new_recovered'],
          totalRecoverd: data['total_recovered'],
          updateDate: data['update_date']);
      return covidModel;
    } catch (e) {
      rethrow;
    }
  }
}
