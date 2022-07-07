import 'dart:math';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/widgets/search_widgets/maps_widget.dart';
import 'package:travelling_app/widgets/search_widgets/province_search_widget.dart';
import '../../provider/add_trip_provider.dart';
import '../../widgets/search_widgets/search_bar_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'display.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _isInit = true;
  var _isLoading = false;
  late String lat;
  late String long;
  @override
  void initState() {
    super.initState();

    // print(auth.listOfResId);
  }

  @override
  void didChangeDependencies() {
    var auth = context.read<AddTripProvider>();
    lat = auth.userLatitude;
    long = auth.userLongtitude;
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<AddTripProvider>(context).getAll(lat, long).then((ele) {
        print(ele);
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 1,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 10,
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
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 10.0),
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
