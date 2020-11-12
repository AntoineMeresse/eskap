import 'package:flutter/material.dart';
import 'package:eskap_app/components/topbar.dart';
import 'package:eskap_app/components/map.dart';

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
