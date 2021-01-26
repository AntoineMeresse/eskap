import 'package:eskap_app/components/explorer/eskapInfo.dart';
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
        if (state.favs.isEmpty)
          return Center(child: Text('No favorites escaps'));
        else {
          return ListView.builder(
              itemCount: state.eskaps.length,
              itemBuilder: (BuildContext context, int index) {
                EscapeGame escapeGame = state.eskaps[index];
                if (escapeGame.isFav)
                  return EskapFavoriteItem(eg: escapeGame);
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

class EskapFavoriteItem extends StatelessWidget {
  final EscapeGame eg;

  const EskapFavoriteItem({Key key, @required this.eg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.home),
        title: Text(eg.name),
        subtitle: Text(eg.id),
        trailing: IconButton(
          icon: Icon(Icons.favorite),
          onPressed: () {
            showAlertDialog(context);
          },
        ),
        onTap: () {
          if (eg != null) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EskapInfo(eg: eg)));
          }
        });
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Continue",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onPressed: () {
        BlocProvider.of<EskapBloc>(context)
            .add(EskapRemoveFav(int.parse(eg.id)));
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Delete Escape",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      content: Text(
          "Would you like to remove this escape game from your favorite list ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
