import 'package:flutter/material.dart';
import 'feed_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Define each screen separately to avoid confusion
  final FeedScreen _feedScreen = const FeedScreen();
  final SearchScreen _searchScreen = const SearchScreen();
  final ProfileScreen _profileScreen = const ProfileScreen();

  // Get the current screen based on the selected index
  Widget _getCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return _feedScreen;
      case 1:
        return _searchScreen;
      case 2:
        return _profileScreen;
      default:
        return _feedScreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentScreen(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF1E1E1E), // Dark background matching the app
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Feed'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Search'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile'
            ),
          ],
        ),
      ),
    );
  }
}