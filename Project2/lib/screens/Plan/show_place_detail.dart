import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:travelling_app/colors/colors.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ShowPlaceDetail extends StatefulWidget {
  String? imgPath;
  String? placeName;
  String? shaTypeDescription;
  String? introduction;
  String? detial;
  String? address;
  String? subDistrict;
  String? district;
  String? province;
  String? postcode;
  String? phones;

  ShowPlaceDetail({this.imgPath,
      this.placeName, 
      this.shaTypeDescription,
      this.introduction,
      this.detial,
      this.address,
      this.subDistrict,
      this.district,
      this.province,
      this.postcode,
      this.phones,});

  @override
  State<ShowPlaceDetail> createState() => _ShowPlaceDetailState();
}

class _ShowPlaceDetailState extends State<ShowPlaceDetail>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: kWheat,
          body: Column(
            children: [
              Stack(
                children: [
                  Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                          ),
                          child: widget.imgPath!.isEmpty || widget.imgPath! == 'NULL'  ?  Image.asset('lib/assets/logos/withbg.png',fit: BoxFit.cover,): Image.network(
                            widget.imgPath!,
                            fit: BoxFit.cover,
                          ))  ,
                      height: MediaQuery.of(context).size.width-30,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ])
                  ), // container 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back), iconSize: 30.0, color: widget.imgPath!.isEmpty || widget.imgPath! == 'NULL' ? kBrown : Colors.white,)
                      ],
                    ),
                  ),
                  Positioned(
                      left: 20.0,
                      bottom: 20.0,
                       child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                            widget.district!,
                            maxLines: 2,
                            style: TextStyle(
                              color: widget.imgPath!.isEmpty || widget.imgPath! == 'NULL'? kBrown : Colors.white,
                              fontSize: 32.0,
                              fontWeight: FontWeight.w600,
                              
                              letterSpacing: 1.2,
                            ),
                           ),
                           Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.locationArrow,
                                size: 15.0,
                                color:  widget.imgPath!.isEmpty || widget.imgPath! == 'NULL'? kRed : Colors.white,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(widget.province!, style: TextStyle(color:  widget.imgPath!.isEmpty || widget.imgPath! == 'NULL'? kBrown : Colors.white, fontSize: 20.0),)
                            ],
                           )
                         ],
                       ),
                     ), 
                ],
              ),

             Expanded(
              child:  
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(      
                  children: [
                  if(widget.placeName!.isNotEmpty)...[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8,20,8,8),
                            child: Text(
                              widget.placeName!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          ],
                          if(widget.shaTypeDescription!.isNotEmpty)...[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8,8,8,8),
                            child: Text(
                              widget.shaTypeDescription!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300,
                                // letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          ],
                          Divider(
                            color: Colors.grey,
                            height: 10,
                            thickness: 1,
                            indent: 15,
                            endIndent: 15,
                          ),
                          Row( 
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                    FontAwesomeIcons.locationDot,
                                    size: 15.0,
                                    color: Colors.black,
                                ),
                              ),
                              if(widget.district!.isNotEmpty)...[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 0.0 , 0),
                                child: Text(
                                  widget.district!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w300,
                                    // letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ],
                            if(widget.address!.isNotEmpty)...[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(3, 8, 0.0 , 0),
                                child: Text(
                                  widget.address!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w300,
                                    // letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ]
                          ),
                          Row(
                            children: [

                              if(widget.subDistrict!.isNotEmpty)...[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0.0 , 8),
                                child: Text(
                                  widget.subDistrict!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w300,
                                    // letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          if(widget.postcode!.isNotEmpty)...[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(3, 0, 0.0 , 8),
                            child: Text(
                              widget.postcode!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300,
                                // letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          ],

                            ],
                          ),
                    
                          if(widget.phones!.isNotEmpty)...[
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                    FontAwesomeIcons.phone,
                                    size: 15.0,
                                    color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.phones!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w300,
                                    // letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ],
                          Divider(
                            color: Colors.grey,
                            height: 10,
                            thickness: 1,
                            indent: 15,
                            endIndent: 15,
                          ),
                          if(widget.detial!.isNotEmpty)...[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.detial!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300,
                                // letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          ],
                         ], //children
                        ),
              )
                    ), //expand; 
             ],)
             ), //stack
     
    );
  }
}
