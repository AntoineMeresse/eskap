class Place {
  String address;
  String number;
  String street;
  String city;
  String country;
  double latitude;
  double longitude;
  String id;

  Place({
    this.address,
    this.number,
    this.street,
    this.city,
    this.country,
    this.latitude,
    this.longitude,
    this.id,
  });

  @override
  String toString() {
    return 'Place{addresse: $address, lat: $latitude, Lng: $longitude, id: $id}';
  }
}
