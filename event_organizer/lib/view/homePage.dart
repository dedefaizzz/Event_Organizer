import 'package:event_organizer/colors/colors.dart';
import 'package:event_organizer/fragment/HomeFragment.dart';
import 'package:event_organizer/fragment/BookmarkFragment.dart';
import 'package:event_organizer/fragment/OrderedFragment.dart';
import 'package:event_organizer/fragment/PresenceFragment.dart';
import 'package:event_organizer/view/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class homePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<homePage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  List<Widget> _widgetOptions = <Widget>[
    HomeFragment(),
    OrderedFragment(),
    BookmarkFragment(),
    PresenceFragment(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 350),
      curve: Curves.easeInExpo,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    Get.off(loginScreen(email: '', password: ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
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
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: AppColors.backgroundColor),
            onPressed: _logout,
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: BouncingScrollPhysics(),
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            label: 'Presence',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.backgroundColor,
        unselectedItemColor: AppColors.splashColor.withOpacity(0.5),
        onTap: _onItemTapped,
      ),
    );
  }
}
