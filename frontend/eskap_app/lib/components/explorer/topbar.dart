import 'package:eskap_app/models/suggestion.dart';
import 'package:eskap_app/services/place_service.dart';
import 'package:flutter/material.dart';
import 'package:eskap_app/components/address_search.dart';
import 'package:uuid/uuid.dart';

class TopBar extends StatefulWidget {
  final setCurrentPlace;
  TopBar({Key key, this.setCurrentPlace}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  String searchText = "";

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
                  Container(
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
                            context: context,
                            delegate: AddressSearch(sessionToken));
                        if (result != null) {
                          print("======================================");
                          //print(result);
                          final place = await PlaceApiProvider()
                              .getPlaceDetailFromCompleteAdress(
                                  result.description);
                          setSearchText(place.address);
                          widget.setCurrentPlace(place);
                        }
                      },
                    ),
                  ),
                  VerticalDivider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  IconButton(
                    icon: new Icon(Icons.sort),
                    onPressed: () {
                      print("Button pressed");
                    },
                  ),
                ],
                // )
              ),
            ],
          ),
        ));
  }
}
