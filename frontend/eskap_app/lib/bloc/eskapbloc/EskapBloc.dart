import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

import 'package:eskap_app/bloc/bloc.dart';
import 'package:eskap_app/models/escapeGame.dart';

class EskapBloc extends Bloc<EskapEvent, EskapState> {
  final http.Client httpClient;

  EskapBloc({@required this.httpClient}) : super(EskapInitial());

  @override
  Stream<EskapState> mapEventToState(EskapEvent event) async* {
    final currentState = state;
    if (event is EskapFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is EskapInitial) {
          final eskaps = await _fetchEskap();
          yield EskapSuccess(eskaps: eskaps, hasReachedMax: true);
          return;
        }
        // Here, if want to load 20 by 20
      } catch (_) {
        yield EskapFailure();
      }
    }
  }

  bool _hasReachedMax(EskapState state) =>
      state is EskapSuccess && state.hasReachedMax;

  Future<List<EscapeGame>> _fetchEskap() async {
    final response =
        await httpClient.get("https://eskaps.herokuapp.com/eskaps/");
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((eskap) {
        return EscapeGame(
          id: eskap['id'],
          name: eskap['name'],
          lat: eskap['addresse']['latitude'],
          long: eskap['addresse']['longitude'],
        );
      }).toList();
    } else {
      throw Exception("Error fetching eskap list");
    }
  }
}
