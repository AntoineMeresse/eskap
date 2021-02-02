import 'package:eskap_app/components/explorer/eskapInfo.dart';
import 'package:eskap_app/models/escapeGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eskap_app/bloc/bloc.dart';

import 'eskapAdd.dart';

class EskapList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final EskapBloc eskapbloc = BlocProvider.of<EskapBloc>(context);
    return Scaffold(
      body: EskapListBloc(eskapbloc: eskapbloc),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                        value: eskapbloc,
                        child: EskapAdd(),
                      )));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }
}

class EskapListBloc extends StatelessWidget {
  final EskapBloc eskapbloc;

  const EskapListBloc({Key key, @required this.eskapbloc}) : super(key: key);

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
        if (state.eskaps.isEmpty)
          return Center(child: Text('No data'));
        else {
          return ListView.builder(
              itemCount: state.eskaps.length,
              itemBuilder: (BuildContext context, int index) {
                return EskapWidget(
                    eg: state.eskaps[index], eskapbloc: eskapbloc);
              });
        }
      }
      return null;
    });
  }
}

class EskapWidget extends StatelessWidget {
  final EscapeGame eg;
  final EskapBloc eskapbloc;

  const EskapWidget({Key key, @required this.eg, @required this.eskapbloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.home),
      title: Text(eg.name),
      subtitle: Text(eg.id.toString()),
      trailing: IconButton(
        icon: Icon(eg.isFav ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          if (eg.isFav) {
            BlocProvider.of<EskapBloc>(context).add(EskapRemoveFav(eg.id));
          } else {
            BlocProvider.of<EskapBloc>(context).add(EskapAddFav(eg.id));
          }
        },
      ),
      onTap: () {
        if (eg != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                        value: eskapbloc,
                        child: EskapInfo(eg: eg),
                      )));
        }
      },
    );
  }
}
