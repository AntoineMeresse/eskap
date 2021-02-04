import 'package:equatable/equatable.dart';

class Filter extends Equatable {
  final double minPrice;
  final double maxPrice;
  final String city;
  final String name;
  final List<String> themes;

  Filter({this.minPrice, this.maxPrice, this.city, this.name, this.themes});

  @override
  String toString() {
    return 'Filter | City : $city | Price : $minPrice - $maxPrice';
  }

  @override
  List<Object> get props => [minPrice, maxPrice, city];
}
