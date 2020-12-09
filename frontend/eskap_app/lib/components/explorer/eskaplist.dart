import 'package:flutter/material.dart';

class EskapList extends StatefulWidget {
  @override
  _EskapListState createState() => _EskapListState();
}

class _EskapListState extends State<EskapList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
      child: ListTile(),
    );
  }
}
