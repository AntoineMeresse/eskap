import 'package:eskap_app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:eskap_app/components/explorer/topbar.dart';
import 'package:eskap_app/components/explorer/map.dart';

class Explorer extends StatefulWidget {
  @override
  _ExplorerState createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  // France
  Place currentPlace =
      Place(addresse: "France", lat: 46.52863469527167, long: 2.43896484375);

  void setCurrentPlace(Place place) {
    setState(() {
      this.currentPlace = place;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TopBar(setCurrentPlace: setCurrentPlace),
          EskapMap(currentPlace: currentPlace),
        ],
      ),
    );
  }
}
