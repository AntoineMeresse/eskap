import 'package:flutter/material.dart';
import 'package:eskap_app/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: HomeWithEskapBloc(),
        ),
      ),
    );
  }
}
