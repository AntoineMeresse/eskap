import 'package:flutter/material.dart';
import 'package:eskap_app/components/components.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:eskap_app/bloc/bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  int _widgetIndex = 0;

  bool _map = false;

  final List<Widget> _widgets = [
    EskapMap(),
    EskapList(),
    Favorite(),
    Profile(),
  ];

  void onTabTapped(int index) {
    setState(() {
      if (index == 0) {
        if (_map) {
          _widgetIndex = index;
        } else {
          _widgetIndex = index + 1;
        }
        _map = !_map;
      } else {
        _widgetIndex = index + 1;
      }
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _widgets,
        index: _widgetIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        showSelectedLabels: true, // Hide labels
        showUnselectedLabels: false, // Hide labels
        items: [
          new BottomNavigationBarItem(
            icon: _map
                ? Icon(Icons.explore_outlined, color: Colors.black)
                : Icon(Icons.list_alt_outlined, color: Colors.black),
            activeIcon: _map
                ? Icon(Icons.explore_rounded, color: Colors.black)
                : Icon(Icons.list_alt, color: Colors.black),
            label: _map ? 'Carte' : "Liste",
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline, color: Colors.black),
            activeIcon: Icon(Icons.favorite, color: Colors.black),
            label: 'Favoris',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color: Colors.black),
            activeIcon: Icon(Icons.person, color: Colors.black),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeWithEskapBloc extends StatelessWidget {
  final String url = "https://eskaps.herokuapp.com";
  final String userId;

  HomeWithEskapBloc(this.userId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) =>
            EskapBloc(httpClient: http.Client(), userId: userId, url: url)
              ..add(EskapFetched()),
        child: Home(),
      ),
    );
  }
}
