import 'package:equatable/equatable.dart';
import 'package:eskap_app/models/escapeGame.dart';
import 'package:eskap_app/models/filter.dart';
import 'package:eskap_app/models/user.dart';

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
  final Filter filter;
  final List<EscapeGame> eskapFiltered;
  final User user;

  const EskapSuccess({
    this.eskaps,
    this.filter,
    this.eskapFiltered,
    this.user,
  });

  EskapSuccess copyWith({
    List<EscapeGame> eskaps,
  }) {
    return EskapSuccess(
      eskaps: eskaps ?? this.eskaps,
    );
  }

  @override
  List<Object> get props => [eskaps, filter, eskapFiltered, user];

  @override
  String toString() =>
      'EskapSuccess { eskaps: ${eskaps.length} | eskapsFiltered : ${eskapFiltered.length}}';
}
