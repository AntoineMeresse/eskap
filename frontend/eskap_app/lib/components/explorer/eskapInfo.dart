import 'package:eskap_app/bloc/bloc.dart';
import 'package:eskap_app/models/escapeGame.dart';
import 'package:eskap_app/models/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EskapInfo extends StatefulWidget {
  final EscapeGame eg;
  EskapInfo({Key key, @required this.eg}) : super(key: key);

  @override
  _EskapInfoState createState() => _EskapInfoState();
}

class _EskapInfoState extends State<EskapInfo> {
  static const padding = EdgeInsets.only(top: 30, left: 0, right: 0);
  static const paddingEskapInfoContainer = EdgeInsets.only(top: 10);

  double reviewRate = 2.5;
  bool showReview = false;
  final TextEditingController reviewController = TextEditingController();

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
              eskapInfoContainer(context, eskapAddress()),
              eskapInfoContainer(context, eskapPrice()),
              eskapInfoContainer(context, eskapThemes()),
              eskapInfoContainer(context, eskapDescription()),
              eskapInfoContainer(context, eskapDifficulty()),
              divider(),
              reviewContainer(),
              eskapInfoContainer(context, eskapAddReview(), size: 0.90),
              divider(),
            ],
          ),
        ),
      ],
    );
  }

  Widget eskapInfoContainer(BuildContext context, Widget widget,
      {double size: 1}) {
    return Container(
      padding: paddingEskapInfoContainer,
      child: Center(child: widget),
      width: MediaQuery.of(context).size.width * size,
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
        icon: Icon(widget.eg.isFav ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          if (widget.eg.isFav) {
            BlocProvider.of<EskapBloc>(context)
                .add(EskapRemoveFav(widget.eg.id));
          } else {
            BlocProvider.of<EskapBloc>(context).add(EskapAddFav(widget.eg.id));
          }
        },
      )
    ]);
  }

  Widget eskapImage() {
    String imgURL = widget.eg.imgurl != ""
        ? widget.eg.imgurl
        : "https://cdn.pixabay.com/photo/2016/01/22/11/50/live-escape-game-1155620_960_720.jpg";
    return Image.network(imgURL);
  }

  Widget eskapName() {
    return Text(
      widget.eg.name ?? null,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
    );
  }

  Widget eskapRate() {
    double rate = widget.eg.averageRate();
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(rate > 0 ? '$rate' : 'Pas de notes encore'),
          eskapRateStar(rate: rate),
        ],
      ),
    );
  }

  Widget eskapRateStar({double rate = 3, bool clickable = false}) {
    return RatingBar.builder(
      initialRating: rate,
      minRating: 0,
      ignoreGestures: !clickable,
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
        setState(() {
          reviewRate = rating;
          print(reviewRate);
        });
      },
    );
  }

  Widget eskapAddress() {
    return Text(
      widget.eg.addressToString() ?? "Null",
      style: TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 20,
      ),
    );
  }

  Widget eskapPrice() {
    if (widget.eg.price != null) {
      return Text('Prix : ${widget.eg.price} / €');
    }
    return null;
  }

  Widget eskapThemes() {
    if (widget.eg.themes.length > 0) {
      return Text('Thème(s) : ${widget.eg.themesToString()}');
    }
    return null;
  }

  Widget eskapDescription() {
    if (widget.eg.description != null) {
      return Container(
        child: Text('Description : ${widget.eg.description}'),
      );
    }
    return null;
  }

  Widget eskapDifficulty() {
    if (widget.eg.difficulty != null) {
      return Text('Difficulté : ${widget.eg.difficulty}');
    }
    return null;
  }

  Widget divider() {
    return Divider(
      thickness: 3,
      height: 25,
    );
  }

  Widget reviewContainer() {
    return InkWell(
      onTap: () {
        setState(() {
          showReview = !showReview;
        });
      },
      child: Row(
        children: [
          Icon(showReview ? Icons.expand_less : Icons.expand_more),
          Text(
            "Noter cet Escape Game",
            style: TextStyle(
              fontStyle: !showReview ? FontStyle.normal : FontStyle.italic,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget eskapAddReview() {
    if (showReview) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$reviewRate'),
              eskapRateStar(rate: reviewRate, clickable: true),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: TextField(
                  minLines: 1,
                  maxLines: 3,
                  maxLength: 250,
                  decoration: InputDecoration(
                    labelText: "Commentaire",
                  ),
                  controller: reviewController,
                ),
              ),
              Expanded(
                flex: 2,
                child: TextButton(
                  onPressed: () {
                    print('$reviewRate | ${reviewController.text}');
                    String reviewText = reviewController.text.trim();
                    if (reviewText.length > 0) {
                      Review r = Review(
                        rate: reviewRate,
                        text: reviewText,
                      );
                      BlocProvider.of<EskapBloc>(context)
                          .add(EskapCreateReview(r, widget.eg.id));
                    }
                  },
                  child: Text(
                    "Envoyer",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ],
      );
    }
    return null;
  }
}
