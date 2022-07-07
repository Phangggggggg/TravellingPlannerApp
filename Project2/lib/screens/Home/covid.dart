import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelling_app/models/covid_model.dart';
import 'package:travelling_app/provider/covid_provider.dart';

class CovidScreen extends StatefulWidget {
  @override
  State<CovidScreen> createState() => _CovidScreenState();
}

class _CovidScreenState extends State<CovidScreen> {
  late CovidModel covidModel;
  var _auth;
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<CovidProvider>(context).getCovidDialy().then((value) {
        setState(() {
          _isLoading = false;
        });
        covidModel = value;
        // print(value);
      });
    }
    ;

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(color: Colors.blue),
          )
        : GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: Text('Annoucement Date: ${covidModel.txnDate}'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[200],
                child: Text('new_case: ${covidModel.newCase}'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[300],
                child:  Text('total_case: ${covidModel.totalCase}'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[400],
                child: Text('new_case_excludeabroad: ${covidModel.newCaseExAbroad}'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[500],
                child: Text('total_case_excludeabroad: ${covidModel.totalCaseExAbroad}'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[500],
                child:  Text('new_death : ${covidModel.newCase}'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[600],
                child: Text('total_death: ${covidModel.totalDeath}'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[500],
                child:  Text('new_recovered: ${covidModel.newRecvoered}'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[600],
                child: Text('total_recovered: ${covidModel.totalRecoverd}'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[600],
                child: Text('update_date: ${covidModel.updateDate}'),
              ),
            ],
          );
  }
}
