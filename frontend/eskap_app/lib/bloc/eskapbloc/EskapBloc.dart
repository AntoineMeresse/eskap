import 'dart:async';
import 'dart:convert';

import 'package:eskap_app/models/filter.dart';
import 'package:eskap_app/models/review.dart';
import 'package:eskap_app/models/user.dart';
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
          final user = await _fetchUser();
          final eskaps = await _fetchEskap(user);
          yield EskapSuccess(
            user: user,
            eskaps: eskaps,
          );
          return;
        }
      } catch (_) {
        yield EskapFailure();
      }
    }
    if (event is EskapAddFav) {
      var eskapId = event.eskapId;
      print("This item is going to be added to fav ( $eskapId )");
      if (currentState is EskapSuccess) {
        try {
          final user = await _updateFavDone(userId, eskapId, true, "favs");
          final eskaps = await _fetchEskap(user);
          yield EskapSuccess(eskaps: eskaps, user: user);
          return;
        } catch (_) {}
        return;
      }
    }
    if (event is EskapAddDone) {
      var eskapId = event.eskapId;
      if (currentState is EskapSuccess) {
        try {
          final user = await _updateFavDone(userId, eskapId, true, "done");
          final eskaps = await _fetchEskap(user);
          yield EskapSuccess(eskaps: eskaps, user: user);
          return;
        } catch (_) {}
        return;
      }
    }
    if (event is EskapRemoveFav) {
      var eskapId = event.eskapId;
      print("This item is going to be deleted from fav ( $eskapId )");
      if (currentState is EskapSuccess) {
        try {
          final user = await _updateFavDone(userId, eskapId, false, "favs");
          final eskaps = await _fetchEskap(user);
          yield EskapSuccess(eskaps: eskaps, user: user);
          return;
        } catch (_) {}
        return;
      }
    }
    if (event is EskapRemoveDone) {
      var eskapId = event.eskapId;
      print("This item is going to be deleted from ( $eskapId )");
      if (currentState is EskapSuccess) {
        try {
          print(currentState.user.doneList.toString());
          final user = await _updateFavDone(userId, eskapId, false, "done");
          print(currentState.user.doneList.toString());
          final eskaps = await _fetchEskap(user);
          yield EskapSuccess(eskaps: eskaps, user: user);
          return;
        } catch (_) {}
        return;
      }
    }
    if (event is EskapCreate) {
      print("Escape Create");
      if (currentState is EskapSuccess) {
        try {
          EscapeGame eg = event.eskap;
          String body = json.encode(eg.toJson());
          var response = await httpClient.post(
            '$url/eskaps/',
            headers: {"Content-Type": "application/json"},
            body: body,
          );
          if (response.statusCode == 200) {
            final user = currentState.user;
            final eskaps = await _fetchEskap(user);
            yield EskapSuccess(
              eskaps: eskaps,
              user: user,
            );
            Navigator.pop(event.context);
            return;
          }
        } catch (_) {}
        return;
      }
      return;
    }

    if (event is EskapCreateReview) {
      Review review = event.review;
      int eskapId = event.eskapId;
      if (currentState is EskapSuccess) {
        try {
          Response response = await _addReview(review, eskapId);
          if (response.statusCode == 200) {
            final user = currentState.user;
            final eskaps = await _fetchEskap(user);
            yield EskapSuccess(
              eskaps: eskaps,
              user: user,
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
            final user = currentState.user;
            final eskaps = await _fetchEskap(user);
            yield EskapSuccess(
              eskaps: eskaps,
              user: user,
            );
            return;
          }
        } catch (_) {}
      }
    }

    if (event is EskapFilterEvent) {
      print("====> Filter <====");
      print(event.filter.toString());
      if (currentState is EskapSuccess) {
        try {
          final user = currentState.user;
          final eskaps = currentState.eskaps;
          final filter = event.filter;
          final eskapsFiltered = filterEskaps(eskaps, filter);
          yield EskapSuccess(
            eskaps: eskaps,
            filter: filter,
            eskapFiltered: eskapsFiltered,
            user: user,
          );
          return;
        } catch (_) {}
      }
    }

    if (event is EskapFilterClearEvent) {
      if (currentState is EskapSuccess) {
        try {
          final user = currentState.user;
          final eskaps = currentState.eskaps;
          final filter = null;
          final eskapsFiltered = null;
          yield EskapSuccess(
            eskaps: eskaps,
            filter: filter,
            eskapFiltered: eskapsFiltered,
            user: user,
          );
          return;
        } catch (_) {}
      }
    }
  }

  Future<List<EscapeGame>> _fetchEskap(User user) async {
    final response = await httpClient.get('$url/eskaps/');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      print(data);
      return data.map((eskap) {
        EscapeGame res = EscapeGame.fromJson(
            eskap,
            userId,
            user.favList.contains(eskap['id']),
            user.doneList.contains(eskap['id']));
        return res;
      }).toList();
    } else {
      throw Exception("Error fetching eskap list");
    }
  }

  Future<User> _updateFavDone(
      String userId, int eskapId, bool add, String listname) async {
    String op = add ? "add" : "delete";
    String request = '$url/users/$userId/$listname/$op/$eskapId';
    print(request);
    final response = await httpClient.put(request);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data);
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

  Future<int> _removeReview(int reviewId, int eskapId) async {
    var urlremove = '$url/eskaps/$eskapId/reviews/$reviewId';
    print(urlremove);
    var response = await httpClient.put(urlremove);
    return response.statusCode;
  }

  List<EscapeGame> filterEskaps(List<EscapeGame> eskaps, Filter filter) {
    List<EscapeGame> res = [];
    for (var eskap in eskaps) {
      bool cityF = filterCity(eskap, filter);
      bool priceF = filterPrice(eskap, filter);
      bool nameF = filterName(eskap, filter);
      bool themeF = filterThemes(eskap, filter);
      bool stateF = filterEskapState(eskap, filter);
      if (cityF && priceF && nameF && themeF && stateF) {
        res.add(eskap);
      }
    }
    return res;
  }

  bool filterCity(EscapeGame eskap, Filter filter) {
    if (filter.city == "")
      return true;
    else if (eskap.city.toLowerCase().contains(filter.city)) return true;
    return false;
  }

  bool filterPrice(EscapeGame eskap, Filter filter) {
    if (filter.minPrice > eskap.price)
      return false;
    else if (filter.maxPrice < eskap.price) return false;
    return true;
  }

  bool filterName(EscapeGame eskap, Filter filter) {
    if (filter.name == "")
      return true;
    else if (eskap.name.toLowerCase().contains(filter.name)) return true;
    return false;
  }

  bool filterThemes(EscapeGame eskap, Filter filter) {
    if (filter.themes == "")
      return true;
    else {
      for (var theme in eskap.themes) {
        if (filter.themes.contains(theme.toLowerCase())) return true;
      }
    }
    return false;
  }

  bool filterEskapState(EscapeGame eskap, Filter filter) {
    if (filter.eskapList == 0)
      return true;
    else if (filter.eskapList == 1 && eskap.official)
      return true;
    else if (filter.eskapList == 2 && !eskap.official) return true;
    return false;
  }

  Future<User> _fetchUser() async {
    String userUrl = '$url/users/$userId';
    final response = await httpClient.get('$userUrl');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception("Error fetching User");
    }
  }
}
