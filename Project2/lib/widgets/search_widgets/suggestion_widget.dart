import 'package:flutter/material.dart';
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
    return ListView.builder(
      
        scrollDirection: Axis.vertical,
        itemCount: lst.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print(lst[index].picUrl);
               Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                        return ShowPlaceDetail(  
                                imgPath: lst[index].picUrl, placeName: lst[index].placeName, shaTypeDescription: lst[index].shaTypeDescription, introduction: lst[index].introduction, 
                                detial: lst[index].detial, address: lst[index].address, subDistrict: lst[index].subDistrict, district:  lst[index].district, 
                                province: lst[index].province, postcode: lst[index].postcode, phones: lst[index].phones);
                            },
                ));
              // Get.toNamed('/ShowPlaceDetail');

            },
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
              child: Card(
                
                child: IntrinsicHeight(child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [
                  lst[index].picUrl == 'NULL' || lst[index].picUrl!.isEmpty
                            ? Image.asset(
                              'lib/assets/logos/favspot.png',
                               width: 120,
                      fit: BoxFit.cover
                                )
                            : Image.network(lst[index].picUrl.toString(),
                             width: 120,
                      fit: BoxFit.cover,
                            ),
  Expanded(
    flex: 14,
    child: 
    SizedBox(
      width: MediaQuery.of(context).size.width/2,
      height: 150,
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
                  child: Icon(Icons.create_rounded, color: Colors.black),
                ),
             
                Flexible(
                  child: Text(
                      'Name: ${lst[index].placeName.toString()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ) 
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
                    child: Icon(Icons.place, color: Colors.black),
                  ),
                  Flexible(
                    child:  
                     Text('Address: ' + lst[index].address.toString(), maxLines: 3,  overflow: TextOverflow.ellipsis,
),
                  ),
                ],
              ),
            )],
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 0, 2),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5, 0.0),
                    child: Icon(Icons.location_city, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Flexible(
                    child: Text('District: ' + lst[index].district.toString(),maxLines: 3,  overflow: TextOverflow.ellipsis,
                    ),
                  ),
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
        });
  }
}
