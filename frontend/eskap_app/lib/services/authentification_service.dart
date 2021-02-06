import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp(
      {String email,
      String password,
      String firstname,
      String lastname}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await registerUserInfos(firstname, lastname);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future registerUserInfos(firstname, lastname) async {
    Map data = {
      'id': _firebaseAuth.currentUser.uid.toString(),
      'firstname': firstname.toString(),
      'lastname': lastname.toString(),
      'donelist': [],
      'favlist': []
    };
    String body = json.encode(data);
    var response = await http.post(
      "https://eskaps.herokuapp.com/users/",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print(response.statusCode);
  }
}
