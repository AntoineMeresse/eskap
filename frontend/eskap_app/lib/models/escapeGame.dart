import 'package:eskap_app/models/review.dart';

class EscapeGame {
  final int id;
  final String name;
  final String difficulty;
  final double price;
  final String imgurl;
  final String description;
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

  bool official;

  bool isFav;

  EscapeGame({
    this.id,
    this.name,
    this.difficulty,
    this.price,
    this.imgurl,
    this.description,
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
  });

  @override
  String toString() {
    return 'EscapeGame{name : $name , addresse: $addressToString(), lat: $latitude, Lng: $longitude, id: $id}';
  }

  String addressToString() {
    return 'Address : $number $street $city $country';
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "difficulty": difficulty,
        "price": price,
        "imgurl": imgurl,
        "description": description,
        "number": number,
        "street": street,
        "city": city,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "themes": themes,
        "reviews": reviews,
        "official": isFav
      };

  static EscapeGame fromJson(eskap) {
    return EscapeGame(
        id: eskap['id'],
        name: eskap['name'],
        difficulty: eskap['difficulty'],
        price: eskap['price'],
        imgurl: eskap['imgurl'],
        description: eskap['description'],
        number: eskap['number'],
        street: eskap['street'],
        city: eskap['city'],
        country: eskap['country'],
        latitude: eskap['latitude'],
        longitude: eskap['longitude'],
        //themes: eskap['themes'],
        //reviews: eskap['reviews'],
        official: eskap['official']);
  }
}
