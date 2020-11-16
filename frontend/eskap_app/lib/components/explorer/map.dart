import 'package:eskap_app/components/explorer/topbar.dart';
import 'package:eskap_app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class EskapMap extends StatefulWidget {
  EskapMap({Key key}) : super(key: key);

  @override
  _EskapMapState createState() => _EskapMapState();
}

class _EskapMapState extends State<EskapMap> {
  GoogleMapController mapController;
  Location location = new Location();

  Place currentPlace;
  double zoom;

  @override
  void initState() {
    super.initState();
    zoom = 5;
    currentPlace =
        Place(addresse: "France", lat: 46.52863469527167, long: 2.43896484375);
  }

  void setZoom(Place place) {
    if (place.id.length >= 6) {
      setState(() {
        this.zoom = 18;
      });
    } else {
      setState(() {
        this.zoom = 12;
      });
    }
  }

  void setCurrentPlace(Place place) {
    setState(() {
      this.currentPlace = place;
    });
    setZoom(place);
    _goToNewPosition();
  }

  Future<void> _goToNewPosition() async {
    await mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            zoom: zoom, target: LatLng(currentPlace.lat, currentPlace.long))));
  }

  void addMarker(String markerId, double lat, double long,
      {String title: "MarkerDefaultTitle",
      String snippet: "MarkerDefaultSnippet"}) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: LatLng(lat, long),
          infoWindow: InfoWindow(title: title, snippet: snippet),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  // Markers
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    addMarker("1", 50.46563, 3.253729, title: 'Maison', snippet: 'Antoine');
    addMarker("2", 50.630206, 3.04584);
    mapController = controller;
  }

  Widget eskapMap() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.70,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          initialCameraPosition: CameraPosition(
            target: LatLng(currentPlace.lat, currentPlace.long),
            zoom: zoom,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        TopBar(setCurrentPlace: setCurrentPlace),
        eskapMap(),
        Text(currentPlace.toString()),
      ]),
    );
  }
}
