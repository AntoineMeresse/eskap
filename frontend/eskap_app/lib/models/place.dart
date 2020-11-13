class Place {
  String addresse;
  double lat;
  double long;
  String id;

  Place({
    this.addresse,
    this.lat,
    this.long,
    this.id,
  });

  @override
  String toString() {
    return 'Place{addresse: $addresse, lat: $lat, Lng: $long, id: $id}';
  }
}
