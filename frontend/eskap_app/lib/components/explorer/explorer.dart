import 'package:flutter/material.dart';
import 'package:eskap_app/components/explorer/topbar.dart';
import 'package:eskap_app/components/explorer/map.dart';

class Explorer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TopBar(),
          EskapMap(),
        ],
      ),
    );
  }
}
