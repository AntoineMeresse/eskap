import 'package:eskap_app/bloc/bloc.dart';
import 'package:eskap_app/services/authentification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  final padding = EdgeInsets.fromLTRB(0, 10, 0, 0);
  final styleText = TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EskapBloc, EskapState>(builder: (context, state) {
      if (state is EskapSuccess) {
        return Center(
          child: Column(
            children: [
              Padding(
                child: avatar(state.user.getInitialLetters()),
                padding: padding,
              ),
              Padding(child: Text("${state.user.getName()}"), padding: padding),
              Padding(child: lougoutButton(context), padding: padding),
              Divider(
                thickness: 3,
              ),
              stats(state.user.doneList, state.user.favList),
            ],
          ),
        );
      }
      return Center(
        child: lougoutButton(context),
      );
    });
  }

  Widget avatar(String text) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.blue,
      child: Text(
        text,
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  Widget stats(List<int> doneList, List<int> favList) {
    return Column(
      children: [
        Padding(
          child: Text("Escape games déjà fait : ${doneList.length}",
              style: styleText),
          padding: padding,
        ),
        Padding(
          child: Text("Escape games en favoris : ${favList.length}",
              style: styleText),
          padding: padding,
        ),
      ],
    );
  }

  Widget lougoutButton(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        context.read<AuthenticationService>().signOut();
      },
      child: Text("Sign out"),
    );
  }
}
