import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travelling_app/provider/add_trip_provider.dart';
import 'package:provider/provider.dart';

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
  LatLng _initialcameraposition = LatLng(13.756331, 100.501762);
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
    print(_permissionGranted);
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
    print('current postision ' + currentPosition.toString());
    print('here');
    _initialcameraposition =
        LatLng(currentPosition!.latitude!, currentPosition!.longitude!);
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.latitude} : ${currentLocation.longitude}");

      setState(() {
        currentPosition = currentLocation;
        _initialcameraposition =
            LatLng(currentPosition!.latitude!, currentPosition!.longitude!);
      });
    });
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
  
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(13.756331, 100.501762), zoom: 15),
        ),
      );

  }

  @override
  void initState() {
    super.initState();
    // getLoc();

    getLoc();
  }

  @override
  Widget build(BuildContext context) {
    // getLoc();
    // context.read<AddTripProvider>().setCurrentPosition(currentPosition!);
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            myLocationButtonEnabled: true,
            onCameraMove: (position) => print(position),
            initialCameraPosition:
                CameraPosition(target: _initialcameraposition, zoom: 15),
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
          ),
        ),
        if (currentPosition != null)
          Text(
            "Latitude: ${currentPosition!.latitude}, Longitude: ${currentPosition!.longitude}",
            style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
      ],
    );
  }
}
