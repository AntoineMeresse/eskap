import 'package:eskap_app/bloc/bloc.dart';
import 'package:eskap_app/models/escapeGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'explorer/eskapInfo.dart';

class EskapWidget extends StatelessWidget {
  final EscapeGame eg;

  const EskapWidget({Key key, @required this.eg}) : super(key: key);

  static const TextStyle bold = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final EskapBloc eskapbloc = BlocProvider.of<EskapBloc>(context);
    return Card(
      child: ListTile(
        title: Column(
          children: [
            title(),
            theme(),
            price(),
          ],
        ),
        subtitle: rateAndLocation(),
        trailing: favIcon(context),
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
      ),
    );
  }

  Widget title() {
    return Row(
      children: [
        Text(
          eg.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        if (eg.official)
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Icon(Icons.verified_outlined),
          ),
      ],
    );
  }

  Widget price() {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Row(
          children: [
            Text("Prix : ", style: bold),
            Text('${eg.price} €'),
          ],
        ));
  }

  Widget theme() {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
        child: Row(
          children: [
            Text(eg.themes.length > 1 ? "Thèmes :" : "Thème :", style: bold),
            Text(' ${eg.themes.join(",")}'),
          ],
        ));
  }

  Widget rateAndLocation() {
    return Row(
      children: [
        rateStars(),
        Text(
          " ( ${eg.reviews.length} ) ",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        Text(
          " | ",
          style: bold,
        ),
        Icon(Icons.location_pin),
        Text('${eg.city}'),
      ],
    );
  }

  Widget imageEskap() {
    return CircleAvatar(
        backgroundImage: NetworkImage(
            'https://cdn.pixabay.com/photo/2016/01/22/11/50/live-escape-game-1155620_960_720.jpg'),
        radius: 30);
  }

  Widget rateStars() {
    return RatingBar.builder(
      initialRating: eg.averageRate(),
      minRating: 0,
      ignoreGestures: true,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 15,
      itemPadding: EdgeInsets.symmetric(horizontal: 2.5),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }

  Widget favIcon(BuildContext context) {
    return IconButton(
      icon: Icon(
        eg.isFav ? Icons.favorite : Icons.favorite_border,
        color: eg.isFav ? Colors.deepOrange : Colors.black,
      ),
      onPressed: () {
        if (eg.isFav) {
          showAlertDialog(context);
        } else {
          BlocProvider.of<EskapBloc>(context).add(EskapAddFav(eg.id));
        }
      },
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text(
        "Annuler",
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
        "Confirmer",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onPressed: () {
        BlocProvider.of<EskapBloc>(context).add(EskapRemoveFav(eg.id));
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Supprimer",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      content: Text("Voulez vous retirer cet Escape Game de vos favoris ?"),
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
