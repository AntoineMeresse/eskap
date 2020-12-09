class EscapeGame {
  String addresse;
  double lat;
  double long;
  String id;

  EscapeGame({
    this.addresse,
    this.lat,
    this.long,
    this.id,
  });

  @override
  String toString() {
    return 'EscapeGame{addresse: $addresse, lat: $lat, Lng: $long, id: $id}';
  }
}
