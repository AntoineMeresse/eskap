import 'package:eskap_app/bloc/bloc.dart';
import 'package:eskap_app/models/escapeGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EskapInfo extends StatelessWidget {
  final EscapeGame eg;

  const EskapInfo({Key key, @required this.eg}) : super(key: key);

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
        eskapAddress(),
      ],
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
    return Container(
      child: Text("rate"),
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
}
