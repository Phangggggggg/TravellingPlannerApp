import 'dart:math';

import 'package:flutter/material.dart';
import 'package:travelling_app/api/get_latlong.dart';
import 'package:travelling_app/api/get_place.dart';
import 'package:travelling_app/widgets/search_widgets/maps_widget.dart';
import 'package:travelling_app/widgets/search_widgets/province_search_widget.dart';
import '../../widgets/search_widgets/search_bar_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'display.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
 
  @override
  void initState() {
    super.initState();

    // print(auth.listOfResId);
  }

  @override
  Widget build(BuildContext context) {
    
    
    return SingleChildScrollView(
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 1,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 8,
            child: Container(
              color: Colors.amber,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Username'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: Text('Discover a new places'),
                  ),
                  SearchBarWidget(),
                  Display()
                ],
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: Container(
                color: Colors.red,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Suggestion'),
                  ),
                ])),
          ),
        ],
      ),
    );
  }
}
