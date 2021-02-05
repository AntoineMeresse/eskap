import 'package:eskap_app/bloc/bloc.dart';
import 'package:eskap_app/services/authentification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EskapBloc, EskapState>(builder: (context, state) {
      if (state is EskapSuccess) {
        return Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.blue,
                child: Text(state.user.getInitialLetters()),
              ),
              Text("${state.user.getName()}"),
              RaisedButton(
                onPressed: () {
                  context.read<AuthenticationService>().signOut();
                },
                child: Text("Sign out"),
              ),
              Divider(),
              stats(state.user.doneList, state.user.favList),
            ],
          ),
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  Widget stats(List<int> doneList, List<int> favList) {
    return Column(
      children: [
        Text("Escape games déjà fait : ${doneList.length}"),
        Text("Escape games en favoris : ${favList.length}"),
      ],
    );
  }
}
