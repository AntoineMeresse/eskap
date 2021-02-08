import 'package:eskap_app/components/eskapListTiles.dart';
import 'package:eskap_app/components/explorer/topbar.dart';
import 'package:eskap_app/models/escapeGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eskap_app/bloc/bloc.dart';

class EskapList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TopBar(),
          Expanded(
            child: EskapListBloc(),
          )
        ],
      ),
    );
  }
}

class EskapListBloc extends StatelessWidget {
  const EskapListBloc({Key key}) : super(key: key);

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
        List<EscapeGame> egs =
            state.filter == null ? state.eskaps : state.eskapFiltered;
        if (egs.isEmpty)
          return Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Vos critères de recherches ne correspondent à aucuns escape games.',
              textAlign: TextAlign.center,
            ),
          ));
        else {
          return ListView.builder(
              itemCount: egs.length,
              itemBuilder: (BuildContext context, int index) {
                return EskapWidget(eg: egs[index]);
              });
        }
      }
      return null;
    });
  }
}
