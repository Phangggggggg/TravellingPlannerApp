import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  Location location = Location();
  LocationData? currentPosition;
  late GoogleMapController mapController;
  late GoogleMapController _controller;
  LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
  void getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled =
        await location.serviceEnabled(); // waiting for user to enable  service
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      // if user denied permission
      _permissionGranted =
          await location.requestPermission(); // then request again
      if (_permissionGranted != PermissionStatus.granted) {
        // if granted return nothing
        return;
      }
    }
    currentPosition = await location.getLocation();
    _initialcameraposition =
        LatLng(currentPosition!.latitude!, currentPosition!.longitude!);
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");

      setState(() {
        currentPosition = currentLocation;
        _initialcameraposition =
            LatLng(currentPosition!.latitude!, currentPosition!.longitude!);
      });
  
    });

  }
  
  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _controller;
    location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!),zoom: 15),
        ),
      );
    });
  }

  @override
  void initState(){
    super.initState();
    getLoc();
  }

    @override
    Widget build(BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
            height: MediaQuery.of(context).size.height/2,
        width: MediaQuery.of(context).size.width,
          
              child: GoogleMap(
                initialCameraPosition: CameraPosition(target: _initialcameraposition,zoom: 15),
                
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
              ),
            ),
            if (currentPosition != null)
                    Text(
                      "Latitude: ${currentPosition!.latitude}, Longitude: ${currentPosition!.longitude}",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
          ],
        ),
      );
    }
}
