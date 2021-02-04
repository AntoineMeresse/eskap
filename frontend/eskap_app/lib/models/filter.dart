import 'package:equatable/equatable.dart';

class Filter extends Equatable {
  final double minPrice;
  final double maxPrice;
  final String city;

  Filter({
    this.minPrice,
    this.maxPrice,
    this.city,
  });

  @override
  String toString() {
    return 'Filter | City : $city | Price : $minPrice - $maxPrice';
  }

  @override
  List<Object> get props => [minPrice, maxPrice, city];
}
