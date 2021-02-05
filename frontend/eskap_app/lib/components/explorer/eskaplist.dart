import 'package:eskap_app/components/explorer/eskapInfo.dart';
import 'package:eskap_app/components/explorer/topbar.dart';
import 'package:eskap_app/models/escapeGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eskap_app/bloc/bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    return Card(
      child: ListTile(
        title: Column(
          children: [
            title(),
            theme(),
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

  Widget theme() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        children: [
          Text("Thème(s) :"),
          Text("Theme list"),
        ],
      ),
    );
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
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(Icons.location_pin),
        Text('${eg.city}, ${eg.country}'),
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
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }

  Widget favIcon(BuildContext context) {
    return IconButton(
      icon: Icon(eg.isFav ? Icons.favorite : Icons.favorite_border),
      onPressed: () {
        if (eg.isFav) {
          BlocProvider.of<EskapBloc>(context).add(EskapRemoveFav(eg.id));
        } else {
          BlocProvider.of<EskapBloc>(context).add(EskapAddFav(eg.id));
        }
      },
    );
  }
}
