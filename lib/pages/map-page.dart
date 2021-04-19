import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // Initial location of the Map view
  CameraPosition _initialPoint = CameraPosition(target: LatLng(0.0, 0.0));

  // For controlling the view of the Map
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _initialPoint,
          myLocationEnabled: true,
          mapType: MapType.normal,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _createButton(Icons.add, CameraUpdate.zoomIn()),
                SizedBox(height: 20.0),
                _createButton(Icons.remove, CameraUpdate.zoomOut())
              ],
            ),
          ),
        )
      ],
    );
  }

  _createButton(IconData icon, CameraUpdate cameraUpdate) {
    return ClipOval(
      child: Material(
        color: Colors.blue[100],
        child: InkWell(
          splashColor: Colors.orange,
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: Icon(icon),
          ),
          onTap: () {
            mapController.animateCamera(cameraUpdate);
          },
        ),
      ),
    );
  }
}
