import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
//   final _textcontrollerTEXT = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(9),
              filled: true,
              fillColor: Color.fromARGB(255, 215, 215, 216),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: BorderSide.none,
              ),
              hintText: "Search",
              prefixIcon: Icon(Icons.search, color: Color.fromARGB(255, 92, 91, 91)),
              hintStyle: TextStyle(fontSize: 14)
            ),
      
            onChanged: (value) {
            
            },
          ),
        ],
      ),
    );
  }
}