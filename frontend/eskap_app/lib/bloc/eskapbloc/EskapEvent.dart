import 'package:equatable/equatable.dart';
import 'package:eskap_app/models/escapeGame.dart';

abstract class EskapEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EskapFetched extends EskapEvent {}

class EskapAddFav extends EskapEvent {
  final int eskapId;

  EskapAddFav(this.eskapId);
}

class EskapRemoveFav extends EskapEvent {
  final int eskapId;

  EskapRemoveFav(this.eskapId);
}

class EskapCreate extends EskapEvent {
  final EscapeGame eskap;

  EskapCreate(this.eskap);
}
