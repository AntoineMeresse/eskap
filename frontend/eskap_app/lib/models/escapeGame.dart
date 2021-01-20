import 'package:equatable/equatable.dart';

class EscapeGame extends Equatable {
  final String id;
  final String addresse;
  final double lat;
  final double long;
  final String name;
  final bool isFav;

  EscapeGame({
    this.id,
    this.addresse,
    this.lat,
    this.long,
    this.name,
    this.isFav,
  });

  @override
  String toString() {
    return 'EscapeGame{name : $name , addresse: $addresse, lat: $lat, Lng: $long, id: $id}';
  }

  @override
  List<Object> get props => [id, addresse, lat, long];
}
