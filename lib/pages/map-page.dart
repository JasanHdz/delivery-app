// import 'dart:async';
import 'package:delivery/constants/enviroment.dart' as secrets;
import 'package:delivery/widgets/common/button.dart';
// import 'package:delivery/utils/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // Initial location of the Map view
  CameraPosition _initialPoint =
      CameraPosition(target: LatLng(19.0576039, -98.2094129), zoom: 7.0);

  // For controlling the view of the Map
  GoogleMapController mapController;

  final Geolocator _geolocator = Geolocator();

  Position _currentPosition;
  // String _currentAddress;

  Set<Marker> markers = {};

  // Object for PolylinePoints
  PolylinePoints polylinePoints;

  // List of coordinates to join
  List<LatLng> polylineCoordinates = [];

  // Map storing polylines created by connecting
  // two points
  Map<PolylineId, Polyline> polylines = {};

  Position _originPosition = Position(latitude: 19.0576039, longitude: -98.2094129);
  Position _destinationPosition = Position(latitude: 20.468327, longitude: -97.7150412);

  _getCurrentLocation() async {
    await _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        // Store the position in the variable
        // _currentPosition = position;

        print('CURRENT POS: $_currentPosition');

        // For moving the camera to current location
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 18.0)));
      });
    }).catchError((e) {
      print(e);
    });
  }

  _addMarkers() {
    Marker startMarker = Marker(
        markerId: MarkerId('idStart'),
        position: LatLng(_originPosition.latitude, _originPosition.longitude),
        infoWindow: InfoWindow(
          title: 'Start',
          snippet: 'Punto inicial',
        ),
        icon: BitmapDescriptor.defaultMarker);

    Marker destinationMarker = Marker(
        markerId: MarkerId('idDestination'),
        position: LatLng(_destinationPosition.latitude, _destinationPosition.longitude),
        infoWindow: InfoWindow(title: 'Destination', snippet: 'Punto de fin'),
        icon: BitmapDescriptor.defaultMarker);

    // Adding the markers to the list
    markers.add(startMarker);
    markers.add(destinationMarker);
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      secrets.API_KEY, // Google Maps API Key
      PointLatLng(_originPosition.latitude, _originPosition.latitude),
      PointLatLng(_destinationPosition.latitude, _destinationPosition.latitude),
      travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    _addPolyLine();
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

  @override
  void initState() {
    super.initState();
    // _getCurrentLocation();
    _addMarkers();
    _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          markers: markers != null ? Set<Marker>.from(markers) : null,
          initialCameraPosition: _initialPoint,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          mapType: MapType.normal,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          polylines: Set<Polyline>.of(polylines.values),
          onMapCreated: (GoogleMapController controller) {
            setState(() {
              mapController = controller;
            });
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
        ),
      ],
    );
  }
}
