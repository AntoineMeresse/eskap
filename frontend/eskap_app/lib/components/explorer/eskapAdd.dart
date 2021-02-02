import 'package:eskap_app/bloc/bloc.dart';
import 'package:eskap_app/models/escapeGame.dart';
import 'package:eskap_app/models/place.dart';
import 'package:eskap_app/models/suggestion.dart';
import 'package:eskap_app/services/place_service.dart';
import 'package:flutter/material.dart';
import 'package:eskap_app/components/address_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                children: [
                  name(context),
                  address(context),
                  description(context),
                  prix(context),
                  themes(context),
                  difficulty(context),
                  textadd(context),
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
              "Retour",
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              EscapeGame eg = EscapeGame(
                  name: nameController.text,
                  difficulty: difficultyController.text,
                  price: double.parse(priceController.text),
                  imgurl: "",
                  description: descriptionController.text,
                  number: currentPlace.number != ""
                      ? int.parse(currentPlace.number)
                      : null,
                  street: currentPlace.street ?? "",
                  city: currentPlace.city,
                  country: currentPlace.country,
                  latitude: currentPlace.latitude,
                  longitude: currentPlace.longitude,
                  themes: [themeController.text],
                  reviews: [],
                  isFav: false);
              BlocProvider.of<EskapBloc>(context).add(EskapCreate(eg, context));
            },
            child: Text("Ajouter"),
          )
        ],
      ),
    );
  }

  Widget textadd(BuildContext context) {
    return Container(
        padding: padding,
        child: Text(
            "Votre Escape Game sera ajouté aux escapes games certifiés lorsque celui ci aura été validé 😁"));
  }
}
