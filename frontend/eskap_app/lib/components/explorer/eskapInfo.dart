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
          child: SingleChildScrollView(
            child: Column(
              children: [
                topBar(context),
                Image.network(
                    "https://cdn.pixabay.com/photo/2016/01/22/11/50/live-escape-game-1155620_960_720.jpg"),
                Text(
                  eg.name ?? null,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Text(
                  eg.address ?? "Null",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                  ),
                ),
                Text(eg.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topBar(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      IconButton(
        icon: Icon(eg.isFav ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          //todo
        },
      )
    ]);
  }
}
