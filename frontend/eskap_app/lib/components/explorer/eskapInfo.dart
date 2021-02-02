import 'package:eskap_app/bloc/bloc.dart';
import 'package:eskap_app/models/escapeGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EskapInfo extends StatelessWidget {
  final EscapeGame eg;

  const EskapInfo({Key key, @required this.eg}) : super(key: key);

  static const padding = EdgeInsets.only(top: 30, left: 0, right: 0);
  static const paddingEskapInfoContainer = EdgeInsets.only(top: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EskapBloc, EskapState>(
        builder: (context, state) {
          if (state is EskapSuccess) {
            return SafeArea(
              child: SingleChildScrollView(
                child: infos(context),
              ),
            );
          }
          return Center(
            child: Text("Chargement impossible des données"),
          );
        },
      ),
    );
  }

  Widget infos(context) {
    return Column(
      children: [
        topBar(context),
        eskapImage(),
        eskapName(),
        eskapRate(),
        Container(
          padding: padding,
          child: Column(
            children: [
              eskapInfoContainer(eskapAddress()),
              eskapInfoContainer(eskapPrice()),
              //eskapInfoContainer(eskapThemes()),
              eskapInfoContainer(eskapDescription()),
              eskapInfoContainer(eskapDifficulty()),
            ],
          ),
        ),
      ],
    );
  }

  Widget eskapInfoContainer(Widget widget) {
    return Container(
      padding: paddingEskapInfoContainer,
      child: widget,
    );
  }

  Widget topBar(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      IconButton(
        icon: Icon(eg.isFav ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          if (eg.isFav) {
            BlocProvider.of<EskapBloc>(context).add(EskapRemoveFav(eg.id));
          } else {
            BlocProvider.of<EskapBloc>(context).add(EskapAddFav(eg.id));
          }
        },
      )
    ]);
  }

  Widget eskapImage() {
    String imgURL = eg.imgurl != ""
        ? eg.imgurl
        : "https://cdn.pixabay.com/photo/2016/01/22/11/50/live-escape-game-1155620_960_720.jpg";
    return Image.network(imgURL);
  }

  Widget eskapName() {
    return Text(
      eg.name ?? null,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
    );
  }

  Widget eskapRate() {
    // Loop throw review to know the rate
    double rate = 4.5;
    if (true) {
      return Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$rate'),
          eskapRateStar(rate),
        ],
      ));
    }
    return null;
  }

  Widget eskapRateStar(double rate) {
    return RatingBar.builder(
      initialRating: rate,
      minRating: 1,
      ignoreGestures: true,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 23,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        //
      },
    );
  }

  Widget eskapAddress() {
    return Text(
      eg.addressToString() ?? "Null",
      style: TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 20,
      ),
    );
  }

  Widget eskapPrice() {
    if (eg.price != null) {
      return Text('Prix : ${eg.price} / €');
    }
    return null;
  }

  Widget eskapThemes() {
    if (eg.themes != null) {
      return Text('Themes : ${eg.themes.toString()}');
    }
    return null;
  }

  Widget eskapDescription() {
    if (eg.description != null) {
      return Container(
        child: Text('Description : ${eg.description}'),
      );
    }
    return null;
  }

  Widget eskapDifficulty() {
    if (eg.difficulty != null) {
      return Text('Difficulté : ${eg.difficulty}');
    }
    return null;
  }
}
