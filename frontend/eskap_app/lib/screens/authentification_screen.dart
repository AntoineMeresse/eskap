import 'package:eskap_app/components/authentification/authentification.dart';
import 'package:flutter/material.dart';

class AuthentificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Connexion"),
              Tab(text: "Inscription"),
            ],
          ),
          title: Text('Eskap App'),
        ),
        body: TabBarView(
          children: [
            SignInPage(),
            SignUpPage(),
          ],
        ),
      ),
    );
  }
}
