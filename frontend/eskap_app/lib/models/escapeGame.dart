import 'package:equatable/equatable.dart';
import 'package:eskap_app/models/review.dart';

class EscapeGame extends Equatable {
  final int id;
  final String name;
  final String difficulty;

  final double minprice;
  final double maxprice;

  final String imgurl;
  final String websiteurl;

  final String description;

  final int minplayer;
  final int maxplayer;

  final int roomnumber;

  // Address
  final int number;
  final String street;
  final String city;
  final String country;
  final double latitude;
  final double longitude;
  //
  final List<String> themes;
  final List<Review> reviews;

  final bool official;

  final bool isFav;
  final bool isDone;

  EscapeGame({
    this.id,
    this.name,
    this.difficulty,
    this.minprice,
    this.maxprice,
    this.imgurl,
    this.websiteurl,
    this.description,
    this.minplayer,
    this.maxplayer,
    this.roomnumber,
    this.number,
    this.street,
    this.city,
    this.country,
    this.latitude,
    this.longitude,
    this.themes,
    this.reviews,
    this.official,
    this.isFav,
    this.isDone,
  });

  @override
  String toString() {
    return 'EscapeGame{name : $name , adresse: $addressToString(), lat: $latitude, Lng: $longitude, id: $id}';
  }

  String addressToString() {
    if (street == "" && number == 0) return 'Adresse : $city $country';
    return 'Adresse : $number $street $city $country';
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "difficulty": difficulty,
        "minprice": minprice,
        "maxprice": maxprice,
        "imgurl": imgurl,
        "websiteurl": websiteurl,
        "description": description,
        "minplayer": minplayer,
        "maxplayer": maxplayer,
        "roomnumber": roomnumber,
        "number": number,
        "street": street,
        "city": city,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "themes": themes,
        "reviews": reviews,
        "official": official,
      };

  static EscapeGame fromJson(eskap, userId, bool isFav, bool isDone) {
    return EscapeGame(
        id: eskap['id'],
        name: eskap['name'],
        difficulty: eskap['difficulty'],
        minprice: eskap['minprice'],
        maxprice: eskap['maxprice'],
        imgurl: eskap['imgurl'],
        websiteurl: eskap['websiteurl'],
        description: eskap['description'],
        minplayer: eskap['minplayer'],
        maxplayer: eskap['maxplayer'],
        roomnumber: eskap['roomnumber'],
        number: eskap['number'],
        street: eskap['street'],
        city: eskap['city'],
        country: eskap['country'],
        latitude: eskap['latitude'],
        longitude: eskap['longitude'],
        themes: themesFromJson(eskap['themes']),
        reviews: reviewsFromJson(eskap['reviews'], userId),
        official: eskap['official'] ?? false,
        isFav: isFav,
        isDone: isDone);
  }

  static EscapeGame updateEscapeFromPrevious(EscapeGame eg,
      {bool isFav, bool isDone, Review review}) {
    return EscapeGame(
      id: eg.id,
      name: eg.name,
      difficulty: eg.difficulty,
      minprice: eg.minprice,
      imgurl: eg.imgurl,
      description: eg.description,
      number: eg.number,
      street: eg.street,
      city: eg.city,
      country: eg.country,
      latitude: eg.latitude,
      longitude: eg.longitude,
      themes: eg.themes,
      reviews: review != null ? [...eg.reviews, review] : eg.reviews,
      official: eg.official,
      isFav: isFav == null ? eg.isFav : isFav,
      isDone: isDone == null ? eg.isDone : isDone,
    );
  }

  static List<String> themesFromJson(themes) {
    List<String> res = [];
    for (var theme in themes) {
      res.add(theme.toString());
    }
    return res;
  }

  String themesToString() {
    return themes.join(' ,');
  }

  static List<Review> reviewsFromJson(reviews, userId) {
    List<Review> res = [];
    for (var review in reviews) {
      res.add(Review.fromJson(review, userId));
    }
    return res;
  }

  double averageRate() {
    double res = 0;
    if (reviews.length == 0) return res;
    for (var review in reviews) res += review.rate;
    return res / (reviews.length);
  }

  @override
  List<Object> get props => [
        id,
        name,
        difficulty,
        minprice,
        maxprice,
        imgurl,
        websiteurl,
        description,
        minplayer,
        maxplayer,
        roomnumber,
        number,
        street,
        city,
        country,
        latitude,
        longitude,
        themes,
        reviews,
        official,
        isFav,
        isDone,
      ];
}
