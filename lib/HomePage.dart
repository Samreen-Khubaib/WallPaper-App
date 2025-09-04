import 'package:flutter/material.dart';
import 'WallpapersPage.dart';
import 'ExplorePage.dart';
import 'SettingsPage.dart';
import 'FavouritesPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool isDarkTheme = false; // Track the theme mode

  // List of pages to show in BottomNavigationBar
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      WallpapersPage(),
      ExplorePage(),
      FavouritesPage(),
      SettingsPage(
        isDarkTheme: isDarkTheme,
        toggleTheme: _toggleTheme,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Toggle the theme between dark and light mode
  void _toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
      _pages[3] = SettingsPage(
        isDarkTheme: isDarkTheme,
        toggleTheme: _toggleTheme,
      ); // Update SettingsPage with the new theme state
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme
          ? ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'BaguetScript',
        ),
      )
          : ThemeData.light().copyWith(
        textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'BaguetScript',
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0, // Remove the shadow
          title: Text(
            'Aura Themes',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor, // Set the text color to primary theme color
            ),
          ),
        ),
        body: _pages[_selectedIndex], // Display selected page
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor, // Dynamic primary color
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 5.0,
                offset: Offset(0, -2), // Create a subtle pop-up effect
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Theme.of(context).primaryColor, // Make selected label white
            unselectedItemColor: Colors.grey, // Make unselected label grey
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: _buildIcon(Icons.wallpaper, 0),
                label: 'Wallpapers',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(Icons.explore, 1),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(Icons.favorite, 2),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(Icons.settings, 3), // Settings icon
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom function to build the icon with shadow effect when clicked
  Widget _buildIcon(IconData icon, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(),
      child: Icon(
        icon,
        size: 30,
        color: _selectedIndex == index
            ? Theme.of(context).primaryColor // Set icon color to primary theme color
            : Color(0xFF4E4E4E), // Default icon color when not selected
      ),
    );
  }
}


