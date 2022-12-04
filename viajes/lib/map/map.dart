// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_collection_literals, unused_element

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {
  final LatLng fromPoint = LatLng(-38.956176, -67.920666);
  final LatLng toPoint = LatLng(-38.953724, -67.923921);

  @override
  _MapScreenState createState() => _MapScreenState();
} 

class _MapScreenState extends State<MapScreen> {

  late GoogleMapController _mapController;
  // TODO: Get device location
  Position? currentPosition = Position(
    longitude: 20.608610558425546,
    latitude: -103.41469228824566,
    altitude: 0.0,
    speed: 0.0,
    accuracy: 0.0,
    speedAccuracy: 0.0,
    timestamp: DateTime.now(),
    heading: 0.0,
  );

  // TODO: get coordenates from the final place
  Position? nextPosition = Position(
    longitude: 20.578186375883366,
    latitude: -103.44938537917199,
    altitude: 0.0,
    speed: 0.0,
    accuracy: 0.0,
    speedAccuracy: 0.0,
    timestamp: DateTime.now(),
    heading: 0.0,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
    
      body: GoogleMap(
        mapType: MapType.normal,
        mapToolbarEnabled: false,
        
        initialCameraPosition: CameraPosition(
          target: LatLng(currentPosition!.longitude, currentPosition!.latitude),
          zoom: 13,
        ),
        markers: _createMarkers(),
        //onMapCreated: _onMapCreated(_mapController, currentPosition!, nextPosition!),
      ),
    );
    
  }

  Set<Marker> _createMarkers() {
    var tmp = Set<Marker>();

    tmp.add(
      Marker(
        markerId: MarkerId("fromPoint"),
        position: LatLng(currentPosition!.longitude, currentPosition!.latitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: "From")
      ),
    );
    tmp.add(
      Marker(
        markerId: MarkerId("toPoint"),
        position: LatLng(nextPosition!.longitude, nextPosition!.latitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: "To")

      ),
    );
    return tmp;

    
  }
  // TODO: Fix the _centerView, bug on position, no data send
   void _onMapCreated(GoogleMapController controller, Position currentPosition, Position nextPosition) {
    _mapController = controller;

    _centerView(currentPosition, nextPosition);
  }
  
  _centerView(Position currentPosition, Position nextPosition) async {
    await _mapController.getVisibleRegion();
    var left = min(currentPosition.latitude, nextPosition.latitude);
    var right = max(currentPosition.latitude, nextPosition.latitude);
    var top = max(currentPosition.longitude, nextPosition.longitude);
    var bottom = min(currentPosition.longitude, nextPosition.longitude);
    
    var bounds = LatLngBounds(
      southwest: LatLng(left, bottom),
      northeast: LatLng(right, top),
    );
    var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
    _mapController.animateCamera(cameraUpdate);
  }
  

}