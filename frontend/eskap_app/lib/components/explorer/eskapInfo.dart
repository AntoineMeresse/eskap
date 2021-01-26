import 'package:eskap_app/models/escapeGame.dart';
import 'package:flutter/material.dart';

class EskapInfo extends StatelessWidget {
  final EscapeGame eg;

  const EskapInfo({Key key, @required this.eg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      home: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [Text("Test"), Text("ABC"), Text(eg.toString())],
            ),
          ),
        ),
      ),
    );
  }
}
