import 'package:flutter/material.dart';

class EskapAdd extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  static const double sidePadding = 30;
  static const padding =
      EdgeInsets.only(top: 10, left: sidePadding, right: sidePadding);

  void add(BuildContext context) {
    print("add");
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
        decoration: InputDecoration(
          labelText: "Addresse",
        ),
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
        controller: nameController,
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
        controller: nameController,
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
}
