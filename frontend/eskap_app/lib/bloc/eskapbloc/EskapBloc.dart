import 'dart:async';
import 'dart:convert';

import 'package:eskap_app/models/review.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
    if (event is EskapFetched) {
      try {
        if (currentState is EskapInitial) {
          final favs = await _fetchFavs();
          final eskaps = await _fetchEskap(favs);
          yield EskapSuccess(
            eskaps: eskaps,
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
            final eskaps = await _fetchEskap(newFav);
            yield EskapSuccess(eskaps: eskaps, favs: newFav);
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
          final eskaps = await _fetchEskap(newFav);
          yield EskapSuccess(eskaps: eskaps, favs: newFav);
        } catch (_) {}
        return;
      }
    }
    if (event is EskapCreate) {
      print("Escape Create");
      EscapeGame eg = event.eskap;
      String body = json.encode(eg.toJson());
      var response = await httpClient.post(
        '$url/eskaps/',
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        final favs = await _fetchFavs();
        final eskaps = await _fetchEskap(favs);
        yield EskapSuccess(
          eskaps: eskaps,
          favs: favs,
        );
        Navigator.pop(event.context);
        return;
      } else {
        print("Erreur");
      }
    }

    if (event is EskapCreateReview) {
      Review review = event.review;
      int eskapId = event.eskapId;
      if (currentState is EskapSuccess) {
        try {
          Response response = await _addReview(review, eskapId);
          if (response.statusCode == 200) {
            var favs = currentState.favs;
            //var data = json.decode(response.body); // Change reponse type spring to int
            final eskaps = await _fetchEskap(favs);
            yield EskapSuccess(
              eskaps: eskaps,
              favs: favs,
            );
            return;
          }
        } catch (_) {}
      }
    }

    if (event is EskapDeleteReview) {
      int reviewId = event.reviewId;
      int eskapId = event.eskapId;
      if (currentState is EskapSuccess) {
        try {
          int responseCode = await _removeReview(reviewId, eskapId);
          print('RC ====> $responseCode');
          if (responseCode == 200) {
            final favs = currentState.favs;
            final eskaps = await _fetchEskap(favs);
            yield EskapSuccess(
              eskaps: eskaps,
              favs: favs,
            );
            return;
          }
        } catch (_) {}
      }
    }
  }

  Future<List<EscapeGame>> _fetchEskap(favs) async {
    final response = await httpClient.get('$url/eskaps/');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      print(data);
      return data.map((eskap) {
        EscapeGame res =
            EscapeGame.fromJson(eskap, userId, favs.contains(eskap['id']));
        return res;
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
        //eskapsCpy[i].isFav = newState;
        EscapeGame newEscape =
            EscapeGame.updateEscapeFromPrevious(eskapsCpy[i], isFav: newState);
        eskapsCpy[i] = newEscape;
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

  Future<Response> _addReview(Review review, int eskapId) async {
    Review newReview = Review.updateReviewFromPrevious(
        review, userId, DateTime.now().toString(), true);
    String body = json.encode(newReview.toJson());
    print(body);
    var response = await httpClient.put(
      '$url/eskaps/$eskapId/reviews/',
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print(response.statusCode);
    return response;
  }

  List<EscapeGame> addReviewEskap(
      List<EscapeGame> eskaps, int id, Review review) {
    var eskapsCpy = [...eskaps];
    for (int i = 0; i < eskapsCpy.length; i++) {
      if (id == eskapsCpy[i].id) {
        //eskapsCpy[i].reviews = [...eskapsCpy[i].reviews, review];
        eskapsCpy[i] =
            EscapeGame.updateEscapeFromPrevious(eskapsCpy[i], review: review);
      }
    }
    return eskapsCpy;
  }

  Future<int> _removeReview(int reviewId, int eskapId) async {
    var urlremove = '$url/eskaps/$eskapId/reviews/$reviewId';
    print(urlremove);
    var response = await httpClient.put(urlremove);
    return response.statusCode;
  }

  List<EscapeGame> removeReviewEskap(
      List<EscapeGame> eskaps, int id, int reviewId) {
    var eskapsCpy = [...eskaps];
    for (int i = 0; i < eskapsCpy.length; i++) {
      if (id == eskapsCpy[i].id) {
        for (int j = 0; j < eskapsCpy[i].reviews.length; j++) {
          if (eskapsCpy[i].reviews[j].reviewId == reviewId)
            eskapsCpy[i].reviews.removeAt(j);
        }
      }
    }
    return eskapsCpy;
  }
}
