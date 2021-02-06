import 'package:eskap_app/services/authentification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordControllerVerification =
      TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  String errorMessage = "";

  void setErrorMessage(String eMessage) {
    setState(() {
      errorMessage = eMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
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
                labelText: "Mot de passe",
              ),
            ),
            TextField(
              controller: passwordControllerVerification,
              enableSuggestions: false,
              obscureText: true,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: "Mot de passe confirmation",
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: RaisedButton(
                onPressed: () {
                  if (!emailController.text.trim().contains("@") ||
                      emailController.text.trim().contains(" ")) {
                    setErrorMessage("Addresse mail non valide");
                    return;
                  }
                  if (passwordController.text.length < 6) {
                    setErrorMessage(
                        "Mot de passe doit contenir plus de 6 caractères");
                    return;
                  }
                  if (firstnameController.text.isEmpty) {
                    setErrorMessage("N'oubliez pas de rentrer votre Prénom");
                    return;
                  }
                  if (lastnameController.text.isEmpty) {
                    setErrorMessage("N'oubliez pas de rentrer votre Nom");
                    return;
                  }
                  if (passwordController.text.trim() !=
                      passwordControllerVerification.text.trim()) {
                    setErrorMessage("Les mots de passe ne correspondent pas.");
                    return;
                  } else {
                    setErrorMessage("");
                    context
                        .read<AuthenticationService>()
                        .signUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            firstname: firstnameController.text.trim(),
                            lastname: lastnameController.text.trim())
                        .then((e) => setErrorMessage(e));
                  }
                },
                child: Text("S'enregistrer"),
              ),
            ),
            Text(
              'Déjà un compte ? Onglet "Connexion"',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
