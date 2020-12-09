import 'package:flutter/material.dart';
import 'package:eskap_app/models/escapeGame.dart';

class EskapList extends StatefulWidget {
  @override
  _EskapListState createState() => _EskapListState();
}

class _EskapListState extends State<EskapList> {
  var eg = [];

  void addEscapeGame(String addresse, double lat, double long, String id) {
    setState(() {
      eg.add(new EscapeGame(addresse: addresse, lat: lat, long: long, id: id));
    });
  }

  @override
  void initState() {
    super.initState();
    addEscapeGame("test", 2.0, 2.0, "1");
    addEscapeGame("test2", 2.0, 2.0, "1");
    print(eg);
  }

  Widget _buildRow(EscapeGame eg) {
    return ListTile(
      leading: Icon(Icons.home),
      title: Text("Escape Game"),
      subtitle: Text(eg.addresse),
      selected: true,
      onLongPress: () => (addEscapeGame("Lol", 4.0, 4.0, "1")),
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
