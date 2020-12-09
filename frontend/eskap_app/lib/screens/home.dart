import 'package:flutter/material.dart';
import 'package:eskap_app/components/components.dart';

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
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        showSelectedLabels: false, // Hide labels
        showUnselectedLabels: false, // Hide labels
        items: [
          new BottomNavigationBarItem(
            icon: _map
                ? Icon(Icons.explore_outlined, color: Colors.black)
                : Icon(Icons.list_alt_outlined, color: Colors.black),
            activeIcon: _map
                ? Icon(Icons.explore_rounded, color: Colors.black)
                : Icon(Icons.list_alt, color: Colors.black),
            label: 'Explorer',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline, color: Colors.black),
            activeIcon: Icon(Icons.favorite, color: Colors.black),
            label: 'Favorite',
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
