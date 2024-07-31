import 'package:event_organizer/colors/colors.dart';
import 'package:event_organizer/fragment/HomeFragment.dart';
import 'package:event_organizer/fragment/BookmarkFragment.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<homePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeFragment(),
    Center(child: Text('Presence')),
    BookmarkFragment(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: Image.asset('assets/icon_event_organizer.jpg',
                width: 32, height: 32),
          ),
        ),
        title: Text(
          'Ivent',
          style: TextStyle(
              color: AppColors.splashColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.backgroundColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            label: 'Presence',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.splashColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
