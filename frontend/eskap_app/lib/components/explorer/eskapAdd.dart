import 'package:eskap_app/models/place.dart';
import 'package:eskap_app/models/suggestion.dart';
import 'package:eskap_app/services/place_service.dart';
import 'package:flutter/material.dart';
import 'package:eskap_app/components/address_search.dart';
import "dart:convert";
import 'package:http/http.dart' as http;

class EskapAdd extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController themeController = TextEditingController();
  final TextEditingController difficultyController = TextEditingController();
  Place currentPlace;

  static const double sidePadding = 30;
  static const padding =
      EdgeInsets.only(top: 10, left: sidePadding, right: sidePadding);

  void add(BuildContext context) async {
    print("add");
    Map data = {
      "name": nameController.text,
      "difficulty": difficultyController.text,
      "price": double.parse(priceController.text),
      "imgurl": "",
      "description": descriptionController.text,
      "number": currentPlace.number,
      "street": currentPlace.street,
      "city": currentPlace.city,
      "country": currentPlace.country,
      "latitude": currentPlace.latitude,
      "longitude": currentPlace.longitude,
      "themes": [themeController.text],
      "reviews": [],
      "official": false
    };
    String body = json.encode(data);
    print(body);
    var response = await http.post(
      "https://eskaps.herokuapp.com/eskaps/",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print(response.statusCode);
    if (response.statusCode == 200) showAlertDialog(context);
  }

  void cancel(BuildContext context) {
    print("cancel");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ajouter un Escape Game",
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                name(context),
                address(context),
                description(context),
                prix(context),
                themes(context),
                difficulty(context),
                buttons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget name(BuildContext context) {
    return Container(
      padding: padding,
      child: TextField(
        controller: nameController,
        decoration: InputDecoration(
          labelText: "Nom",
        ),
      ),
    );
  }

  Widget address(BuildContext context) {
    return Container(
      padding: padding,
      child: TextField(
        controller: addressController,
        decoration: InputDecoration(labelText: "Addresse"),
        readOnly: true, // On peut écrire ou non
        onTap: () async {
          final sessionToken = "";
          final Suggestion result = await showSearch(
              context: context, delegate: AddressSearch(sessionToken));
          if (result != null) {
            final place = await PlaceApiProvider()
                .getPlaceDetailFromCompleteAdress(result.description);
            addressController.text = (place.address);
            currentPlace = place;
            print(currentPlace.toString());
          }
        },
      ),
    );
  }

  Widget description(BuildContext context) {
    return Container(
      padding: padding,
      child: TextField(
        controller: descriptionController,
        decoration: InputDecoration(
          labelText: "Description",
        ),
      ),
    );
  }

  Widget prix(BuildContext context) {
    return Container(
      padding: padding,
      child: TextField(
        controller: priceController,
        decoration: InputDecoration(
          labelText: "Prix  (€ / personne)",
        ),
      ),
    );
  }

  Widget themes(BuildContext context) {
    return Container(
      padding: padding,
      child: TextField(
        controller: themeController,
        decoration: InputDecoration(
          labelText: "Theme",
        ),
      ),
    );
  }

  Widget difficulty(BuildContext context) {
    return Container(
      padding: padding,
      child: TextField(
        controller: difficultyController,
        decoration: InputDecoration(
          labelText: "Difficulté",
        ),
      ),
    );
  }

  Widget buttons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              cancel(context);
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              add(context);
            },
            child: Text("Add"),
          )
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget continueButton = FlatButton(
      child: Text(
        "Ok",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Ajout Escape Game",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      content: Text(
          "Votre Escape Game sera ajouté lorsque celui ci aura été validé"),
      actions: [
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
