import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'LoginPage.dart';

class SettingsPage extends StatefulWidget {
  final bool isDarkTheme;
  final VoidCallback toggleTheme;

  SettingsPage({
    required this.isDarkTheme,
    required this.toggleTheme,
  });

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool showDarkModeToggle = false;

  // Logout function with confirmation dialog
  Future<void> _logout() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _handleLogout();
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);

      // Use a custom page transition to navigate to the LoginPage with fade effect
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 700),
        ),
      );
    } catch (e) {
      print("Error during logout: $e");
    }
  }



  // Function to open email client
  Future<void> _openEmailClient() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'samreenkhubaib01@gmail.com',
      query: 'subject=Contact Us&body=Hello Team,', // Optional subject and body
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Could not launch email client.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                'assets/images/sticker.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                _buildElevatedOption(
                  title: 'Change Mode',
                  onTap: () {
                    setState(() {
                      showDarkModeToggle = !showDarkModeToggle;
                    });
                  },
                ),
                if (showDarkModeToggle)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Enable Dark Mode', style: TextStyle(fontSize: 16.0)),
                        Switch(
                          value: widget.isDarkTheme,
                          onChanged: (value) {
                            widget.toggleTheme();
                            setState(() {
                              showDarkModeToggle = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                _buildElevatedOption(
                  title: 'Logout',
                  onTap: _logout,
                ),
                _buildElevatedOption(
                  title: 'Contact Us',
                  onTap: _openEmailClient,
                ),
                _buildElevatedOption(
                  title: 'Current Version: 1.0.0',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildElevatedOption({required String title, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: widget.isDarkTheme ? Colors.grey[800] : Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: widget.isDarkTheme ? Colors.white : Colors.black, // Change text color
                ),
              ),
              if (onTap != null) Icon(Icons.arrow_forward_ios, size: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
