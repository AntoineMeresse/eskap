import 'package:eskap_app/bloc/bloc.dart';
import 'package:eskap_app/models/escapeGame.dart';
import 'package:eskap_app/models/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class EskapInfo extends StatefulWidget {
  final EscapeGame eg;
  EskapInfo({Key key, @required this.eg}) : super(key: key);

  @override
  _EskapInfoState createState() => _EskapInfoState();
}

class _EskapInfoState extends State<EskapInfo> {
  static const padding = EdgeInsets.only(top: 30, left: 0, right: 0);
  static const paddingEskapInfoContainer =
      EdgeInsets.symmetric(horizontal: 20, vertical: 10);

  double reviewRate = 2.5;
  bool showAddReview = false;
  bool showReviews = false;
  final TextEditingController reviewController = TextEditingController();

  EscapeGame eg;

  void resetForm() {
    setState(() {
      reviewRate = 2.5;
    });
    reviewController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EskapBloc, EskapState>(
        builder: (context, state) {
          if (state is EskapSuccess) {
            for (var eskap in state.eskaps)
              if (eskap.id == widget.eg.id) eg = eskap;
            return SafeArea(
              child: SingleChildScrollView(
                child: infos(context, state),
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

  Widget infos(context, state) {
    return Column(
      children: [
        topBar(context),
        eskapImage(),
        eskapName(),
        eskapRate(),
        eskapWebsite(),
        divider(),
        Container(
          padding: padding,
          child: Column(
            children: [
              eskapInfoContainer(context, eskapAddress()),
              eskapInfoContainer(context, eskapPrice()),
              eskapInfoContainer(context, eskapPlayers()),
              eskapInfoContainer(context, eskapThemes()),
              eskapInfoContainer(context, eskapDifficulty()),
              eskapInfoContainer(context, eskapDescription()),
            ],
          ),
        ),
        divider(),
        addReviewContainer(),
        eskapInfoContainer(context, eskapAddReview(), size: 0.90),
        divider(),
        allReviewsContainer(),
        eskapInfoContainer(context, eskapDisplayAllReviews(context, state)),
        divider(),
      ],
    );
  }

  Widget eskapInfoContainer(BuildContext context, Widget widget,
      {double size: 1}) {
    if (widget != null)
      return Container(
        padding: paddingEskapInfoContainer,
        child: widget,
        width: MediaQuery.of(context).size.width * size,
      );
    return Container();
  }

  Widget topBar(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      Row(
        children: [
          doneButton(),
          favButton(),
        ],
      ),
    ]);
  }

  Widget doneButton() {
    return FlatButton(
      splashColor: Colors.grey[100],
      onPressed: () {
        if (eg.isDone) {
          BlocProvider.of<EskapBloc>(context).add(EskapRemoveDone(eg.id));
        } else {
          BlocProvider.of<EskapBloc>(context).add(EskapAddDone(eg.id));
        }
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: !eg.isDone ? Colors.grey : Colors.green,
            radius: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("Fait"),
          ),
        ],
      ),
    );
  }

  Widget favButton() {
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

  Widget eskapImage() {
    String imgURL = eg.imgurl != ""
        ? eg.imgurl
        : "https://cdn.pixabay.com/photo/2016/01/22/11/50/live-escape-game-1155620_960_720.jpg";
    return Image.network(imgURL);
  }

  Widget eskapName() {
    return Text(
      eg.name ?? null,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
    );
  }

  Widget eskapRate() {
    double rate = eg.averageRate();
    int nbReviews = eg.reviews.length;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(rate > 0
                ? '${rate.toStringAsFixed(2)}'
                : 'Pas de notes encore'),
            eskapRateStar(rate: rate),
            Text('( $nbReviews )'),
          ],
        ),
      ),
    );
  }

  Widget eskapRateStar(
      {double rate = 3, bool clickable = false, double itemSize = 23}) {
    return RatingBar.builder(
      initialRating: rate,
      minRating: 0,
      ignoreGestures: !clickable,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: itemSize,
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
      eg.addressToString() ?? "Null",
    );
  }

  Widget eskapPrice() {
    if (eg.minprice != 0 && eg.maxprice != 0) {
      return Text(
          'Prix : de ${eg.minprice}€ à ${eg.maxprice}€ selon le nombre de personnes');
    }
  }

  Widget eskapPlayers() {
    if (eg.minprice != null) {
      return Text('Personnes : de ${eg.minplayer} à ${eg.maxplayer} joueurs');
    }

    return null;
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //         <--- border radius here
          ),
    );
  }

  List<Widget> themes(List<String> themes) {
    List<Widget> res = [];
    res.add(Text(themes.length > 1 ? "Thèmes : " : "Theme : "));
    for (var theme in themes) {
      res.add(
        Container(
          decoration: myBoxDecoration(),
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.all(3),
          child: Text(toUpperFirst(theme)),
        ),
      );
    }
    return res;
  }

  Widget eskapThemes() {
    if (eg.themes.length > 0) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: themes(eg.themes),
        ),
      );
    }
    return null;
  }

  Widget eskapDescription() {
    if (eg.description != "") {
      return Container(
        child: Text('Description : ${eg.description}'),
      );
    }
    return null;
  }

  Widget eskapDifficulty() {
    if (eg.difficulty != "") {
      return Text('Difficulté : ${eg.difficulty}');
    }
    return null;
  }

  Widget divider() {
    return Divider(
      thickness: 3,
      height: 25,
    );
  }

  Widget addReviewContainer() {
    return InkWell(
      onTap: () {
        resetForm();
        setState(() {
          showAddReview = !showAddReview;
        });
      },
      child: Row(
        children: [
          Icon(showAddReview ? Icons.expand_less : Icons.expand_more),
          Text(
            "Noter cet Escape Game",
            style: TextStyle(
              fontStyle: !showAddReview ? FontStyle.normal : FontStyle.italic,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget eskapAddReview() {
    if (showAddReview) {
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
                          .add(EskapCreateReview(r, eg.id));
                      resetForm();
                      FocusScope.of(context).unfocus();
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

  Widget allReviewsContainer() {
    return InkWell(
      onTap: () {
        setState(() {
          showReviews = !showReviews;
        });
      },
      child: Row(
        children: [
          Icon(showReviews ? Icons.expand_less : Icons.expand_more),
          Text(
            'Avis (${eg.reviews.length})',
            style: TextStyle(
              fontStyle: !showAddReview ? FontStyle.normal : FontStyle.italic,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget eskapDisplayAllReviews(context, state) {
    if (showReviews) {
      if (eg.reviews.isEmpty)
        return Center(child: Text("Pas d'avis pour le moment 😐"));
      else {
        return SizedBox(
          height: 300,
          child: ListView.builder(
              itemCount: eg.reviews.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  subtitle: Text(
                    '"${eg.reviews[index].text.trim()}"',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  title:
                      eskapRateStar(rate: eg.reviews[index].rate, itemSize: 15),
                  trailing: eg.reviews[index].isOwner
                      ? IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red[900],
                          ),
                          onPressed: () {
                            BlocProvider.of<EskapBloc>(context).add(
                                EskapDeleteReview(
                                    eg.reviews[index].reviewId, eg.id));
                          },
                        )
                      : null,
                  onTap: () {},
                  tileColor: (index % 2 == 0) ? Colors.grey[300] : Colors.white,
                );
              }),
        );
      }
    } else
      return null;
  }

  String toUpperFirst(String s) {
    if (s.length >= 1) return '${s[0].toUpperCase()}${s.substring(1)}';
    return "";
  }

  Widget eskapWebsite() {
    if (eg.websiteurl != "") {
      return MaterialButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: () async {
          var url = eg.websiteurl;
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        child: Text('Escape Game Website'),
      );
    }
    return Container();
  }
}
