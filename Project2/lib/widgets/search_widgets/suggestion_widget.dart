import 'package:flutter/material.dart';
import 'package:travelling_app/colors/colors.dart';
import 'package:travelling_app/models/place_model.dart';
import 'package:travelling_app/models/trips.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart'; 
import '/screens/Plan/show_place_detail.dart';

class SuggestionWidget extends StatelessWidget {
//   List<Trips> lst;
  List<PlaceModel> lst;

  SuggestionWidget({required this.lst});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: lst.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print(lst[index].picUrl);
                 Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                          return ShowPlaceDetail(  
                                  placeModel: lst[index], isShow: true);
                              },
                  ));
                // Get.toNamed('/ShowPlaceDetail');

              },
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                child: Card(
                elevation: 0,
                color: kWheat,                  
                  child: IntrinsicHeight(child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: [
                    lst[index].picUrl == 'NULL' || lst[index].picUrl!.isEmpty
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(
                                  'lib/assets/logos/favspot.png',
                                   width: 120,
                                                      fit: BoxFit.cover
                                    ),
                              )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(lst[index].picUrl.toString(),
                                 width: 120,
                                                      fit: BoxFit.cover,
                                ),
                              ),
  Expanded(
      flex: 14,
      child: 
      SizedBox(
        width: MediaQuery.of(context).size.width/2 + 70,
        height: 170,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 0, 2),
                child: Row(
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5, 0.0),
                    child: Icon(Icons.create_rounded, color: kBrown),
                  ),
               
                  Flexible(
                    child: RichText(
                      maxLines: 3,
                      overflow:  TextOverflow.ellipsis,
                        text: TextSpan(
                          text: lst[index].placeName.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: kBrown),
                          // children: <TextSpan>[
                          //   TextSpan(text: lst[index].placeName.toString(), style: TextStyle(color: kBrown, fontWeight: FontWeight.normal)), 
                          // ],
                      ),
                   
                  ) 
                  ),
                  ],
                ),
              ),
              if(lst[index].address!.isNotEmpty )...[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 2, 0, 2),
                child: lst[index].address!.isEmpty  ? Text(''): Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5, 0.0),
                      child: Icon(Icons.place, color:kBrown),
                    ),
                    Flexible(
                      child: RichText(
                      maxLines: 3,
                      overflow:  TextOverflow.ellipsis,
                        text: TextSpan(
                          text: 'Address: ', style: TextStyle(fontWeight: FontWeight.bold, color: kBrown),
                          children: <TextSpan>[
                            TextSpan(text: lst[index].address.toString(), style: TextStyle(color: kBrown, fontWeight: FontWeight.normal)), 
                          ],
                      ),
                   
                    ) 
                  )
                  ],
                ),
              )],
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 2, 0, 2),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5, 0.0),
                      child: Icon(Icons.location_city, color: kBrown),
                    ),
                    SizedBox(height: 20),
                    Flexible(
                      child: RichText(
                      maxLines: 3,
                      overflow:  TextOverflow.ellipsis,
                        text: TextSpan(
                          text: 'District: ', style: TextStyle(fontWeight: FontWeight.bold, color: kBrown),
                          children: <TextSpan>[
                            TextSpan(text: lst[index].district.toString(), style: TextStyle(color: kBrown, fontWeight: FontWeight.normal)), 
                          ],
                      ),
                   
                    ) 
                  )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
  ),
                              
                  ]),)
                  

                ),
              ),
            );
          }),
    );
  }
}
