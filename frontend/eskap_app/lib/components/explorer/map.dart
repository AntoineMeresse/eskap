import 'package:eskap_app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class EskapMap extends StatefulWidget {
  final Place currentPlace;

  EskapMap({Key key, this.currentPlace}) : super(key: key);

  @override
  _EskapMapState createState() => _EskapMapState();
}

class _EskapMapState extends State<EskapMap> {
  GoogleMapController mapController;

  // Map => France
  //LatLng _center;
  final double _zoom = 5;

  Location location = new Location();

  Future<void> _goToNewPosition() async {
    await mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            zoom: 12,
            target:
                LatLng(widget.currentPlace.long, widget.currentPlace.lat))));
  }

  void moveCamera(LatLng l) {
    _goToNewPosition();
  }

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

  Widget eskapMap() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.70,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.currentPlace.lat, widget.currentPlace.long),
            zoom: _zoom,
          ),
          onTap: moveCamera,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        eskapMap(),
        Text(widget.currentPlace.toString()),
      ]),
    );
  }
}
