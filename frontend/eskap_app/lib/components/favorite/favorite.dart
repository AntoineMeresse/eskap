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
          child: CircularProgressIndicator(),
        );
      }
      if (state is EskapFailure) {
        return Center(child: Text('Failed to fetch datas'));
      }
      if (state is EskapSuccess) {
        if (state.user.favList.isEmpty)
          return Center(child: Text('No favorites escaps'));
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
