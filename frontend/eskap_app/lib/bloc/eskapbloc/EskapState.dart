import 'package:equatable/equatable.dart';
import 'package:eskap_app/models/escapeGame.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class EskapState extends Equatable {
  const EskapState();

  @override
  List<Object> get props => [];
}

class EskapInitial extends EskapState {}

class EskapFailure extends EskapState {}

class EskapSuccess extends EskapState {
  final List<EscapeGame> eskaps;
  final bool hasReachedMax;
  final Set<Marker> markers;
  final List<int> favs;

  const EskapSuccess({
    this.eskaps,
    this.hasReachedMax,
    this.markers,
    this.favs,
  });

  EskapSuccess copyWith({
    List<EscapeGame> eskaps,
    bool hasReachedMax,
  }) {
    return EskapSuccess(
      eskaps: eskaps ?? this.eskaps,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [eskaps, hasReachedMax, markers, favs];

  @override
  String toString() =>
      'EskapSuccess { eskaps: ${eskaps.length}, hasReachedMax: $hasReachedMax }';
}
