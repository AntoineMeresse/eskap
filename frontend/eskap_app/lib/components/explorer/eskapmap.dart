import 'package:eskap_app/components/explorer/eskapInfo.dart';
import 'package:eskap_app/components/explorer/topbar.dart';
import 'package:eskap_app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eskap_app/bloc/bloc.dart';

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

  BitmapDescriptor bitmapDescriptor;

  @override
  void initState() {
    super.initState();
    loadEskapIcon();
    zoom = 5;
    currentPlace = Place(
        address: "France",
        latitude: 46.52863469527167,
        longitude: 2.43896484375);
  }

  void loadEskapIcon() async {
    bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/eskap-resize.png');
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
    await mapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            zoom: zoom,
            target: LatLng(
              currentPlace.latitude,
              currentPlace.longitude,
            ))));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Widget eskapMap(Set<Marker> markers) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.70,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: markers,
          initialCameraPosition: CameraPosition(
            target: LatLng(currentPlace.latitude, currentPlace.longitude),
            zoom: zoom,
          ),
        ));
  }

  Widget eskapBloc() {
    return BlocBuilder<EskapBloc, EskapState>(builder: (context, state) {
      if (state is EskapSuccess) {
        Set<Marker> res = {};
        state.eskaps.forEach(
          (eskap) => res.add(
            Marker(
              markerId: MarkerId(eskap.id.toString()),
              position: LatLng(eskap.latitude, eskap.longitude),
              infoWindow: InfoWindow(
                title: eskap.name,
                snippet: 'Id : ${eskap.id}',
                onTap: () {
                  if (eskap != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EskapInfo(eg: eskap)));
                  }
                },
              ),
              icon: bitmapDescriptor,
            ),
          ),
        );
        return eskapMap(res);
      }
      return eskapMap({});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        TopBar(setCurrentPlace: setCurrentPlace),
        eskapBloc(),
        //Text(currentPlace.toString()),
      ]),
    );
  }
}
