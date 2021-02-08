import 'package:eskap_app/bloc/bloc.dart';
import 'package:eskap_app/models/escapeGame.dart';
import 'package:eskap_app/models/place.dart';
import 'package:eskap_app/models/suggestion.dart';
import 'package:eskap_app/services/place_service.dart';
import 'package:flutter/material.dart';
import 'package:eskap_app/components/address_search.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EskapAdd extends StatefulWidget {
  @override
  _EskapAddState createState() => _EskapAddState();
}

class _EskapAddState extends State<EskapAdd> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController themeController = TextEditingController();
  final TextEditingController urlImageController = TextEditingController();
  Place currentPlace;
  String _selectedDifficulty;

  static const double sidePadding = 30;
  static const padding =
      EdgeInsets.only(top: 20, left: sidePadding, right: sidePadding);

  void cancel(BuildContext context) {
    print("cancel");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EskapBloc, EskapState>(builder: (context, state) {
        if (state is EskapSuccess) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () => cancel(context)),
                  name(),
                  address(),
                  description(),
                  urlImage(),
                  prix(),
                  themes(),
                  difficulty(),
                  textadd(),
                  buttons(context),
                ],
              ),
            ),
          );
        }
        return Center(
          child: Text("Unknow"),
        );
      }),
    );
  }

  Widget name() {
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

  Widget address() {
    return Container(
      padding: padding,
      child: TextField(
        controller: addressController,
        decoration: InputDecoration(labelText: "Adresse"),
        readOnly: true, // On peut écrire ou non
        onTap: () async {
          final Suggestion result =
              await showSearch(context: context, delegate: AddressSearch(null));
          if (result != null) {
            final place = await PlaceApiProvider()
                .getPlaceDetailFromCompleteAdress(result.description);
            addressController.text = (place.address);
            setState(() {
              currentPlace = place;
            });
          }
        },
      ),
    );
  }

  Widget description() {
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

  Widget prix() {
    return Container(
      padding: padding,
      child: TextField(
        controller: priceController,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow((RegExp("[.,0-9]")))
        ],
        decoration: InputDecoration(
          labelText: "Prix  (€ / personne)",
        ),
      ),
    );
  }

  Widget themes() {
    return Container(
      padding: padding,
      child: TextField(
        controller: themeController,
        decoration: InputDecoration(
          labelText: "Themes",
          hintText: "Séparer par des virgules",
        ),
      ),
    );
  }

  Widget difficulty() {
    return Center(
      child: Container(
        padding: padding,
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text("Choisir difficulté"),
          value: _selectedDifficulty,
          items: [
            DropdownMenuItem(
              child: Text("Facile 🙂"),
              value: "facile",
            ),
            DropdownMenuItem(
              child: Text("Moyen 🧐"),
              value: "moyen",
            ),
            DropdownMenuItem(
              child: Text("Difficile 😈"),
              value: "difficile",
            ),
          ],
          onChanged: (String value) {
            setState(() {
              _selectedDifficulty = value;
            });
          },
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
              "Retour",
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              EscapeGame eg = EscapeGame(
                  name: nameController.text,
                  difficulty: _selectedDifficulty ?? "facile",
                  minprice:
                      double.parse(priceController.text.replaceAll(",", '.')),
                  imgurl: urlImageController.text.trim(),
                  description: descriptionController.text,
                  number: currentPlace.number != ""
                      ? int.parse(currentPlace.number)
                      : null,
                  street: currentPlace.street ?? "",
                  city: currentPlace.city,
                  country: currentPlace.country,
                  latitude: currentPlace.latitude,
                  longitude: currentPlace.longitude,
                  themes: themeController.text
                      .replaceAll(" ", "")
                      .toLowerCase()
                      .split(","),
                  reviews: [],
                  official: false,
                  isFav: false,
                  isDone: false);
              BlocProvider.of<EskapBloc>(context).add(EskapCreate(eg, context));
            },
            child: Text("Ajouter"),
          )
        ],
      ),
    );
  }

  Widget textadd() {
    return Container(
        padding: padding,
        child: Text(
            "Votre Escape Game sera ajouté aux escapes games certifiés lorsque celui ci aura été validé 😁"));
  }

  Widget urlImage() {
    return Container(
      padding: padding,
      child: TextField(
        controller: urlImageController,
        decoration: InputDecoration(
          labelText: "Image",
          hintText: "Entrer une Url d'image",
        ),
      ),
    );
  }
}
