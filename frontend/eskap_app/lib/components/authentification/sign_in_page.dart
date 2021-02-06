import 'package:eskap_app/services/authentification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
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
                  setErrorMessage("");
                  context
                      .read<AuthenticationService>()
                      .signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      )
                      .then((e) => setErrorMessage(e));
                },
                child: Text("Se connecter"),
              ),
            ),
            Text(
              'Déjà un compte ? Onglet "Inscription"',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
