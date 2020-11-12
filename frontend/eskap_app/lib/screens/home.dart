import 'package:flutter/material.dart';
import 'package:eskap_app/components/components.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _widgets = [
    Explorer(),
    Favorite(),
    Profile(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _widgets,
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        showSelectedLabels: false, // Hide labels
        showUnselectedLabels: false, // Hide labels
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.map_outlined, color: Colors.black),
            activeIcon: new Icon(Icons.map, color: Colors.black),
            label: 'Explorer',
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.favorite_outline, color: Colors.black),
            activeIcon: new Icon(Icons.favorite, color: Colors.black),
            label: 'Favorite',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color: Colors.black),
            activeIcon: new Icon(Icons.person, color: Colors.black),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
