import 'package:equatable/equatable.dart';

abstract class EskapEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EskapFetched extends EskapEvent {}
