import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class EskapMap extends StatefulWidget {
  @override
  _EskapMapState createState() => _EskapMapState();
}

class _EskapMapState extends State<EskapMap> {
  GoogleMapController mapController;

  // Map => France
  final LatLng _center = const LatLng(46.52863469527167, 2.43896484375);
  final double _zoom = 5;

  Location location = new Location();

  // Markers
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("1"),
          position: LatLng(50.46563, 3.253729),
          infoWindow: InfoWindow(title: 'Maison', snippet: 'Antoine'),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      print("===========> ");
      print(_markers.length);
    });
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: _zoom,
          ),
        ));
  }
}
