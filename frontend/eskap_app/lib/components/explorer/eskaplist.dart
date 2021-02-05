import 'package:eskap_app/components/explorer/eskapInfo.dart';
import 'package:eskap_app/models/escapeGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eskap_app/bloc/bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'eskapAdd.dart';

class EskapList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final EskapBloc eskapbloc = BlocProvider.of<EskapBloc>(context);
    return Scaffold(
      body: EskapListBloc(),
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
  const EskapListBloc({Key key}) : super(key: key);

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
        List<EscapeGame> egs =
            state.filter == null ? state.eskaps : state.eskapFiltered;
        if (egs.isEmpty)
          return Center(child: Text('No data'));
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

class EskapWidget extends StatelessWidget {
  final EscapeGame eg;

  const EskapWidget({Key key, @required this.eg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final EskapBloc eskapbloc = BlocProvider.of<EskapBloc>(context);
    return ListTile(
      title: Row(
        children: [
          Text(eg.name),
          if (eg.official) (Icon(Icons.verified_outlined)),
        ],
      ),
      subtitle: RatingBar.builder(
        initialRating: eg.averageRate(),
        minRating: 0,
        ignoreGestures: true,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: 25,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {},
      ),
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
