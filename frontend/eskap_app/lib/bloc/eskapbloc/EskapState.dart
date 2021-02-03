import 'package:equatable/equatable.dart';
import 'package:eskap_app/models/escapeGame.dart';

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

  const EskapSuccess({
    this.eskaps,
    this.favs,
  });

  EskapSuccess copyWith({
    List<EscapeGame> eskaps,
    bool hasReachedMax,
  }) {
    return EskapSuccess(
      eskaps: eskaps ?? this.eskaps,
    );
  }

  @override
  List<Object> get props => [eskaps, favs];

  @override
  String toString() => 'EskapSuccess { eskaps: ${eskaps.length}}';
}
