import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String firstname;
  final String lastname;
  final List<int> doneList;
  final List<int> favList;

  User({this.firstname, this.lastname, this.doneList, this.favList});

  @override
  String toString() {
    return 'User : ';
  }

  String getName() {
    return '$firstname $lastname';
  }

  String getInitialLetters() {
    return '${firstname[0]} ${lastname[0]}'.toUpperCase();
  }

  @override
  List<Object> get props => [firstname, lastname, doneList, favList];

  static User fromJson(user) {
    return User(
      firstname: user['firstname'],
      lastname: user['lastname'],
      doneList: [],
      favList: [],
    );
  }
}
