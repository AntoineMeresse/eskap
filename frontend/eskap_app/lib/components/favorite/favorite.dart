import 'package:eskap_app/components/eskapListTiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eskap_app/bloc/bloc.dart';
import 'package:eskap_app/models/escapeGame.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EskapBloc, EskapState>(builder: (context, state) {
      if (state is EskapInitial) {
        return Center(
          child: Row(
            children: [
              Text("Chargement des données"),
              CircularProgressIndicator(),
            ],
          ),
        );
      }
      if (state is EskapFailure) {
        return Center(child: Text("Les données n'ont pas pu être chargées."));
      }
      if (state is EskapSuccess) {
        if (state.user.favList.isEmpty)
          return Center(
              child: Text("Vous n'avez pas encore d'escape game en favoris."));
        else {
          return ListView.builder(
              itemCount: state.eskaps.length,
              itemBuilder: (BuildContext context, int index) {
                EscapeGame escapeGame = state.eskaps[index];
                if (escapeGame.isFav)
                  return EskapWidget(eg: escapeGame);
                // ! Verify if there is a better way of doing this !
                else
                  return Container(width: 0, height: 0);
              });
        }
      }
      return null;
    });
  }
}
