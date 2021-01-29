import 'package:eskap_app/services/authentification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordControllerVerification =
      TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            controller: passwordController,
            enableSuggestions: false,
            obscureText: true,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Password",
            ),
          ),
          TextField(
            controller: passwordControllerVerification,
            enableSuggestions: false,
            obscureText: true,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Password Confirmation",
            ),
          ),
          TextField(
            controller: firstnameController,
            decoration: InputDecoration(
              labelText: "Prenom",
            ),
          ),
          TextField(
            controller: lastnameController,
            decoration: InputDecoration(
              labelText: "Nom",
            ),
          ),
          RaisedButton(
            onPressed: () {
              if (passwordController.text.trim() ==
                  passwordControllerVerification.text.trim()) {
                context.read<AuthenticationService>().signUp(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    firstname: firstnameController.text.trim(),
                    lastname: lastnameController.text.trim());
              }
            },
            child: Text("Sign Up"),
          )
        ],
      ),
    );
  }
}
