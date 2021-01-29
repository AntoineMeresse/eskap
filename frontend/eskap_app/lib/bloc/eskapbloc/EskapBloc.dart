import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

import 'package:eskap_app/bloc/bloc.dart';
import 'package:eskap_app/models/escapeGame.dart';

class EskapBloc extends Bloc<EskapEvent, EskapState> {
  final http.Client httpClient;
  final String userId;
  final String url;

  EskapBloc({@required this.httpClient, this.userId, @required this.url})
      : super(EskapInitial());

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
          try {
            final newFav = await _updateFav(userId, eskapId, true);
            var newEskaps =
                replaceIsFavEskap(currentState.eskaps, eskapId, true);
            yield EskapSuccess(
                eskaps: newEskaps, hasReachedMax: true, favs: newFav);
          } catch (_) {}
        }
        return;
      }
    }
    if (event is EskapRemoveFav) {
      var eskapId = event.eskapId;
      print("This item is going to be deleted to fav ( $eskapId )");
      if (currentState is EskapSuccess) {
        try {
          final newFav = await _updateFav(userId, eskapId, false);
          var newEskaps =
              replaceIsFavEskap(currentState.eskaps, eskapId, false);
          yield EskapSuccess(
              eskaps: newEskaps, hasReachedMax: true, favs: newFav);
        } catch (_) {}
        return;
      }
    }
  }

  bool _hasReachedMax(EskapState state) =>
      state is EskapSuccess && state.hasReachedMax;

  Future<List<EscapeGame>> _fetchEskap(favs) async {
    final response = await httpClient.get('$url/eskaps/');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      print(data);
      return data.map((eskap) {
        return EscapeGame(
          id: eskap['id'],
          name: eskap['name'],
          difficulty: eskap['difficulty'],
          price: eskap['price'],
          imgurl: eskap['imgurl'],
          description: eskap['description'],
          number: eskap['number'],
          street: eskap['street'],
          city: eskap['city'],
          country: eskap['country'],
          latitude: eskap['latitude'],
          longitude: eskap['longitude'],
          //themes: eskap['themes'],
          //reviews: eskap['reviews'],
          isFav: favs.contains(eskap['id']),
        );
      }).toList();
    } else {
      throw Exception("Error fetching eskap list");
    }
  }

  Future<List<int>> _fetchFavs() async {
    final response = await httpClient.get('$url/users/$userId/favs');
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
      if (id == eskapsCpy[i].id) {
        print(i);
        eskapsCpy[i].isFav = newState;
      }
    }
    return eskapsCpy;
  }

  Future<List<int>> _updateFav(String userId, int eskapId, bool add) async {
    String op = add ? "add" : "delete";
    String request = '$url/users/$userId/favs/$op/$eskapId';
    final response = await httpClient.put(request);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.cast<int>();
    } else {
      throw Exception("Error fetching fav list");
    }
  }
}
