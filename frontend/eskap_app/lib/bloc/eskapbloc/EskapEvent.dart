import 'package:equatable/equatable.dart';
import 'package:eskap_app/models/escapeGame.dart';
import 'package:eskap_app/models/review.dart';
import 'package:flutter/material.dart';

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
  final BuildContext context;

  EskapCreate(this.eskap, this.context);
}

class EskapCreateReview extends EskapEvent {
  final Review review;
  final int eskapId;

  EskapCreateReview(this.review, this.eskapId);
}

class EskapDeleteReview extends EskapEvent {
  final int reviewId;
  final int eskapId;

  EskapDeleteReview(this.reviewId, this.eskapId);
}
