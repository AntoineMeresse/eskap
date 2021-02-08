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

  final TextEditingController nbRoomController = TextEditingController();

  final TextEditingController priceMinController = TextEditingController();
  final TextEditingController priceMaxController = TextEditingController();

  final TextEditingController personMinController = TextEditingController();
  final TextEditingController personMaxController = TextEditingController();

  final TextEditingController themeController = TextEditingController();

  final TextEditingController urlImageController = TextEditingController();
  final TextEditingController urlWebsiteController = TextEditingController();
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
                  urlWebsite(),
                  roomNumber(),
                  prix(),
                  personne(),
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

  Widget prixWidget(TextEditingController textEditingController, String label) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.50,
      padding: padding,
      child: TextField(
        controller: textEditingController,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow((RegExp("[.,0-9]")))
        ],
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }

  Widget prix() {
    return Row(
      children: [
        prixWidget(priceMinController, "Prix min"),
        prixWidget(priceMaxController, "Prix max"),
      ],
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
              if (nameController.text != "" && currentPlace != null) {
                EscapeGame eg = EscapeGame(
                    name: nameController.text,
                    difficulty: _selectedDifficulty ?? "facile",
                    minprice: priceMinController.text != ""
                        ? double.parse(
                            priceMinController.text.replaceAll(",", '.'))
                        : 0,
                    maxprice: priceMaxController.text != ""
                        ? double.parse(
                            priceMaxController.text.replaceAll(",", '.'))
                        : 0,
                    imgurl: urlImageController.text.trim(),
                    websiteurl: urlWebsiteController.text.trim(),
                    roomnumber: nbRoomController.text != ""
                        ? int.parse(nbRoomController.text)
                        : 0,
                    minplayer: personMinController.text != ""
                        ? int.parse(personMinController.text)
                        : 0,
                    maxplayer: personMaxController.text != ""
                        ? int.parse(personMaxController.text)
                        : 0,
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
                BlocProvider.of<EskapBloc>(context)
                    .add(EskapCreate(eg, context));
              }
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
          labelText: "Image URL",
          hintText: "Entrer une Url d'image",
        ),
      ),
    );
  }

  Widget urlWebsite() {
    return Container(
      padding: padding,
      child: TextField(
        controller: urlWebsiteController,
        decoration: InputDecoration(
          labelText: "Site Web URL",
          hintText: "Entrer l'url du site web",
        ),
      ),
    );
  }

  Widget personneWidget(
      TextEditingController textEditingController, String label) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.50,
      padding: padding,
      child: TextField(
        controller: textEditingController,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow((RegExp("[0-9]")))
        ],
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }

  Widget personne() {
    return Column(
      children: [
        Row(
          children: [
            personneWidget(personMinController, "Participants min"),
            personneWidget(personMaxController, "Participants max"),
          ],
        ),
      ],
    );
  }

  Widget roomNumber() {
    return Container(
      padding: padding,
      child: TextField(
        controller: nbRoomController,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow((RegExp("[0-9]")))
        ],
        decoration: InputDecoration(
          labelText: "Nombre de salle(s)",
        ),
      ),
    );
  }
}
