import 'package:eskap_app/bloc/bloc.dart';
import 'package:eskap_app/models/filter.dart';
import 'package:eskap_app/models/suggestion.dart';
import 'package:eskap_app/services/place_service.dart';
import 'package:flutter/material.dart';
import 'package:eskap_app/components/address_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'eskapFilter.dart';

class TopBar extends StatefulWidget {
  final setCurrentPlace;
  TopBar({Key key, this.setCurrentPlace}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  String searchText = "";

  Filter filter = Filter(city: "", minPrice: 0, maxPrice: 100);

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
        height: MediaQuery.of(context).size.height * 0.065,
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  searchBar(),
                  divider(),
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
          final sessionToken = Uuid().v4();
          final Suggestion result = await showSearch(
              context: context, delegate: AddressSearch(sessionToken));
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

  Widget divider() {
    return VerticalDivider(
      thickness: 2,
      color: Colors.black,
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
}
