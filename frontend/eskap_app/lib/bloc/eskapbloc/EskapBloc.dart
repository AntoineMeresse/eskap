import 'dart:async';
import 'dart:convert';

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
          final markers = _transformMarkers(eskaps);
          yield EskapSuccess(
              eskaps: eskaps,
              hasReachedMax: true,
              markers: markers,
              favs: favs);
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

  Set<Marker> _transformMarkers(List<EscapeGame> eskaps) {
    Set<Marker> res = {};
    if (eskaps.isNotEmpty && eskaps != null) {
      print("TRANSFORM");
      eskaps.forEach((eskap) {
        //print(eskap.toString());
        res.add(
          Marker(
            markerId: MarkerId(eskap.id),
            position: LatLng(eskap.lat, eskap.long),
            infoWindow:
                InfoWindow(title: eskap.name, snippet: 'Id : ${eskap.id}'),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
      });
    }
    return res;
  }

  Future<List<int>> _fetchFavs() async {
    final response = await httpClient
        .get('https://eskaps.herokuapp.com/users/${userId}/favs');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.cast<int>();
    } else {
      throw Exception("Error fetching fav list");
    }
  }
}
