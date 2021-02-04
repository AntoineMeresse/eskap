import 'package:equatable/equatable.dart';
import 'package:eskap_app/models/escapeGame.dart';
import 'package:eskap_app/models/filter.dart';

abstract class EskapState extends Equatable {
  const EskapState();

  @override
  List<Object> get props => [];
}

class EskapInitial extends EskapState {}

class EskapAdded extends EskapState {}

class EskapFailure extends EskapState {}

class EskapSuccess extends EskapState {
  final List<EscapeGame> eskaps;
  final List<int> favs;
  final Filter filter;
  final List<EscapeGame> eskapFiltered;

  const EskapSuccess({
    this.eskaps,
    this.favs,
    this.filter,
    this.eskapFiltered,
  });

  EskapSuccess copyWith({
    List<EscapeGame> eskaps,
  }) {
    return EskapSuccess(
      eskaps: eskaps ?? this.eskaps,
    );
  }

  @override
  List<Object> get props => [eskaps, favs, filter, eskapFiltered];

  @override
  String toString() =>
      'EskapSuccess { eskaps: ${eskaps.length} | eskapsFiltered : ${eskapFiltered.length}}';
}
