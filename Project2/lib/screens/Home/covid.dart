import 'package:flutter/material.dart';


class CovidScreen extends StatelessWidget {
  const CovidScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
            Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[100],
            child: const Text("txn_date"),
            ),
            Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[200],
            child: const Text('new_case'),
            ),
            Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[300],
            child: const Text('total_case'),
            ),
            Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[400],
            child: const Text('new_case_excludeabroad'),
            ),
            Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[500],
            child: const Text('total_case_excludeabroad'),
            ),
            Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[500],
            child: const Text('new_death'),
            ),
            Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[600],
            child: const Text('total_death'),
            ),
            Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[500],
            child: const Text('new_recovered'),
            ),
            Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[600],
            child: const Text('total_recovered'),
            ),
            Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[600],
            child: const Text('update_date'),
            ),
        ],
    );
  }
}