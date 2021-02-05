import 'package:eskap_app/bloc/bloc.dart';
import 'package:eskap_app/models/filter.dart';
import 'package:eskap_app/models/suggestion.dart';
import 'package:eskap_app/services/place_service.dart';
import 'package:flutter/material.dart';
import 'package:eskap_app/components/address_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'eskapAdd.dart';
import 'eskapFilter.dart';

class TopBar extends StatefulWidget {
  final setCurrentPlace;
  TopBar({Key key, this.setCurrentPlace}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  String searchText = "";

  Filter filter = Filter(
      city: "", minPrice: 0, maxPrice: 100, name: "", themes: "", eskapList: 0);

  void saveCurrentFilter(Filter newfilter) {
    print("update filter");
    setState(() {
      filter = newfilter;
    });
  }

  void setSearchText(String newText) {
    setState(() {
      searchText = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.setCurrentPlace != null ? searchBar() : addEskapButton(),
              filterButton(),
            ],
            // )
          ),
        ],
      ),
    ));
  }

  Widget searchBar() {
    return Container(
      margin: const EdgeInsets.only(left: 6, right: 5),
      width: MediaQuery.of(context).size.width * 0.80,
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          hintText: searchText,
          border: InputBorder.none,
        ),
        readOnly: true, // On peut écrire ou non
        onTap: () async {
          final Suggestion result =
              await showSearch(context: context, delegate: AddressSearch(null));
          if (result != null) {
            final place = await PlaceApiProvider()
                .getPlaceDetailFromCompleteAdress(result.description);
            setSearchText(place.address);
            widget.setCurrentPlace(place);
          }
        },
      ),
    );
  }

  Widget filterButton() {
    return IconButton(
      icon: new Icon(Icons.sort),
      onPressed: () {
        showAlertDialog(context);
      },
    );
  }

  showAlertDialog(BuildContext context) {
    //ignore: close_sinks
    final EskapBloc eskapbloc = BlocProvider.of<EskapBloc>(context);
    AlertDialog alert = AlertDialog(
      title: Text(
        "Filtre(s)",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      content: SingleChildScrollView(
        child: BlocProvider.value(
            value: eskapbloc,
            child: EskapFilter(
              filter: filter,
              setCurrentFilter: saveCurrentFilter,
            )),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget addEskapButton() {
    //ignore: close_sinks
    final EskapBloc eskapbloc = BlocProvider.of<EskapBloc>(context);
    return TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                        value: eskapbloc,
                        child: EskapAdd(),
                      )));
        },
        child: Text("Ajouter un escape game"));
  }
}
