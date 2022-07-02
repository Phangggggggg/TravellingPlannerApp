import 'package:flutter/material.dart';
import 'package:travelling_app/widgets/trip_widget.dart';

class OnGoingTripWidget extends StatefulWidget {

    String placeName; 
    String dateOfGoing; 

    OnGoingTripWidget(
        { required this.placeName, required this.dateOfGoing }
    );

  @override
  State<OnGoingTripWidget> createState() => _OnGoingTripWidgetState();
}

class _OnGoingTripWidgetState extends State<OnGoingTripWidget> {

    late PageController _pageController =
      PageController(viewportFraction: 1, initialPage: 0);
    int _currentPage = 0; 

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      child: PageView.builder( 
          controller: _pageController, 
          itemCount: 4, 
          itemBuilder: (_, i) {
              return TripWidget();
              },
          ),
    );
    }
}

