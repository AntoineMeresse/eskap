import 'dart:async';
import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

import 'package:eskap_app/bloc/bloc.dart';
import 'package:eskap_app/models/escapeGame.dart';

class EskapBloc extends Bloc<EskapEvent, EskapState> {
  final http.Client httpClient;
  final int userId;

  EskapBloc({@required this.httpClient, this.userId}) : super(EskapInitial());

  @override
  Stream<EskapState> mapEventToState(EskapEvent event) async* {
    final currentState = state;
    if (event is EskapFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is EskapInitial) {
          final favs = await _fetchFavs();
          final eskaps = await _fetchEskap(favs);
          yield EskapSuccess(
            eskaps: eskaps,
            hasReachedMax: true,
            favs: favs,
          );
          return;
        }
        // Here, if want to load 20 by 20
      } catch (_) {
        yield EskapFailure();
      }
    }
    if (event is EskapAddFav) {
      var eskapId = event.eskapId;
      print("This item is going to be added to fav ( $eskapId )");
      if (currentState is EskapSuccess) {
        if (!currentState.favs.contains(eskapId)) {
          var newFav = [...currentState.favs, event.eskapId];
          print("Current favs : " + newFav.toString());
          var newEskaps = replaceIsFavEskap(currentState.eskaps, eskapId, true);
          yield EskapSuccess(
              eskaps: newEskaps, hasReachedMax: true, favs: newFav);
        }
        return;
      }
    }
    if (event is EskapRemoveFav) {
      var eskapId = event.eskapId;
      print("This item is going to be deleted to fav ( $eskapId )");
      if (currentState is EskapSuccess) {
        var newFav = [...currentState.favs];
        newFav.remove(eskapId);
        var newEskaps = replaceIsFavEskap(currentState.eskaps, eskapId, false);
        yield EskapSuccess(
            eskaps: newEskaps, hasReachedMax: true, favs: newFav);
        return;
      }
    }
  }

  bool _hasReachedMax(EskapState state) =>
      state is EskapSuccess && state.hasReachedMax;

  Future<List<EscapeGame>> _fetchEskap(favs) async {
    final response =
        await httpClient.get("https://eskaps.herokuapp.com/eskaps/");
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      print(data);
      return data.map((eskap) {
        return EscapeGame(
          id: eskap['id'].toString(),
          name: eskap['name'],
          lat: eskap['address']['latitude'],
          long: eskap['address']['longitude'],
          isFav: favs.contains(eskap['id']),
        );
      }).toList();
    } else {
      throw Exception("Error fetching eskap list");
    }
  }

  Future<List<int>> _fetchFavs() async {
    final response =
        await httpClient.get('https://eskaps.herokuapp.com/users/$userId/favs');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.cast<int>();
    } else {
      throw Exception("Error fetching fav list");
    }
  }

  List<EscapeGame> replaceIsFavEskap(
      List<EscapeGame> eskaps, int id, bool newState) {
    var eskapsCpy = [...eskaps];
    for (int i = 0; i < eskapsCpy.length; i++) {
      if (id.toString() == eskapsCpy[i].id) {
        print(i);
        eskapsCpy[i].isFav = newState;
      }
    }
    return eskapsCpy;
  }
}
