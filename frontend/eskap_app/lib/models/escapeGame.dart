import 'package:equatable/equatable.dart';
import 'package:eskap_app/models/review.dart';

class EscapeGame extends Equatable {
  final int id;
  final String name;
  final String difficulty;
  // Address
  final int number;
  final String street;
  final String city;
  final String country;
  final double latitude;
  final double longitude;
  String address;
  //
  final List<String> themes;
  final List<Review> reviews;

  bool isFav;

  EscapeGame({
    this.id,
    this.name,
    this.difficulty,
    this.number,
    this.street,
    this.city,
    this.country,
    this.latitude,
    this.longitude,
    this.themes,
    this.reviews,
    this.isFav,
  }) {
    this.address = addressToString();
  }

  @override
  String toString() {
    return 'EscapeGame{name : $name , addresse: $addressToString(), lat: $latitude, Lng: $longitude, id: $id}';
  }

  String addressToString() {
    return '$number $street $city $country';
  }

  @override
  List<Object> get props => [
        id,
        name,
        difficulty,
        number,
        street,
        city,
        country,
        latitude,
        longitude,
        themes,
        reviews,
        isFav
      ];
}
