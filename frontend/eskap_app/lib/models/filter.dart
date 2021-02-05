import 'package:equatable/equatable.dart';

class Filter extends Equatable {
  final double minPrice;
  final double maxPrice;
  final String city;
  final String name;
  final String themes;
  final int eskapList;

  Filter(
      {this.minPrice,
      this.maxPrice,
      this.city,
      this.name,
      this.themes,
      this.eskapList});

  @override
  String toString() {
    return 'Filter | City : $city | Price : $minPrice - $maxPrice | Name : $name | Themes : $themes | EskapList : $eskapList';
  }

  @override
  List<Object> get props => [minPrice, maxPrice, city, name, themes, eskapList];
}
