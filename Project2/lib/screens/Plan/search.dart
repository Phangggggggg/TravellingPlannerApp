import 'package:flutter/material.dart';
import 'package:travelling_app/widgets/search_widgets/maps_widget.dart';
import '../../widgets/search_widgets/search_bar_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return MapWidget();
      // return SingleChildScrollView(
      //   child: StaggeredGrid.count(
      //           crossAxisCount: 2, 
      //           mainAxisSpacing: 4,
      //           crossAxisSpacing: 1,
      //           children: [
      //             StaggeredGridTile.count(crossAxisCellCount: 2, mainAxisCellCount: 4, child: MapWidget()),
      //             StaggeredGridTile.count(
      //               crossAxisCellCount: 2,
      //               mainAxisCellCount: 1.2,
      //               child: Container(color: Colors.amber,child:
      //                Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   SizedBox(
      //                     height: 40,
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.all(10.0),
      //                     child: Text('Username'),
      //                   ),
                        
      //                   Padding(
      //                     padding: const EdgeInsets.only(left: 10.0),
      //                     child: Text('Discover a new place'),
      //                   ),
      //                   SearchBarWidget()
      //                 ],
      //                ),),
      //             ),
      //             StaggeredGridTile.count(
      //               crossAxisCellCount: 2,
      //               mainAxisCellCount: 1,
      //               child: Container(color: Colors.red,
      //                 child: Column(

      //                   children: [
      //                     Padding(
      //                     padding: const EdgeInsets.all(10.0),
      //                     child: Text('Suggestion'),
      //                     ),
      //                   ]
      //                 )
      //               ),
      //             ),
      //              StaggeredGridTile.count(
      //               crossAxisCellCount: 2,
      //               mainAxisCellCount: 1,
      //               child: Container(color: Colors.red,),
      //             ),
      //               StaggeredGridTile.count(
      //               crossAxisCellCount: 2,
      //               mainAxisCellCount: 2,
      //               child: Container(color: Colors.pink,),
      //             ),
                 
      //           ],
      //         ),
      // );
  }
}