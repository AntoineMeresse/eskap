import 'package:eskap_app/models/suggestion.dart';
import 'package:flutter/material.dart';
import 'package:eskap_app/components/address_search.dart';
import 'package:uuid/uuid.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.075,
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
                        hintText: "Entrer une adresse ...",
                        border: InputBorder.none,
                      ),
                      readOnly: true, // On peut écrire ou non
                      onTap: () async {
                        final sessionToken = Uuid().v4();
                        final Suggestion result = await showSearch(
                            context: context,
                            delegate: AddressSearch(sessionToken));
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
              // Divider(
              //   thickness: 0,
              //   color: Colors.black,
              // ),
            ],
          ),
        ));
  }
}
