import 'package:flutter/material.dart';
import 'package:eskap_app/models/escapeGame.dart';
import 'dart:math';

class EskapList extends StatefulWidget {
  @override
  _EskapListState createState() => _EskapListState();
}

class _EskapListState extends State<EskapList> {
  var eg = [];

  final _saved = Set<String>();
  Random r = new Random();

  void addEscapeGame(String addresse, double lat, double long, String id) {
    setState(() {
      eg.add(new EscapeGame(addresse: addresse, lat: lat, long: long, id: id));
    });
  }

  @override
  void initState() {
    super.initState();
    addEscapeGame("test", 2.0, 2.0, "1");
    addEscapeGame("test2", 2.0, 2.0, "2");
    print(eg);
  }

  Widget _buildRow(EscapeGame eg) {
    final alreadySaved = _saved.contains(eg.id);

    return ListTile(
      leading: Icon(Icons.home),
      title: Text("Escape Game"),
      subtitle: Text(eg.addresse),
      onLongPress: () =>
          (addEscapeGame("NEW EG", 4.0, 4.0, r.nextInt(10000).toString())),
      trailing: IconButton(
        icon: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(eg.id);
            } else
              _saved.add(eg.id);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
      child: ListView.builder(
        itemCount: eg.length,
        itemBuilder: (context, index) {
          return _buildRow(eg[index]);
        },
      ),
    );
  }
}
