import 'package:flutter/material.dart';
import 'package:eskap_app/components/explorer/map.dart';
import 'package:eskap_app/components/explorer/eskaplist.dart';

class Explorer extends StatefulWidget {
  @override
  _ExplorerState createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  // France

  @override
  Widget build(BuildContext context) {
    return Container(
      //child: EskapMap(),
      child: EskapList(),
    );
  }
}
