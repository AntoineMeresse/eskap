import 'package:eskap_app/screens/sign_in_page.dart';
import 'package:eskap_app/screens/sign_up_page.dart';
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
              Tab(text: "Sign In"),
              Tab(text: "Sign Up"),
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
