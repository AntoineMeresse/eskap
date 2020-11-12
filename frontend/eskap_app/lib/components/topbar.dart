import 'package:flutter/material.dart';

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
                        hintText: "Location",
                        border: InputBorder.none,
                      ),
                      readOnly: false, // On peut écrire ou non
                      onTap: () async {
                        //TODO
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
