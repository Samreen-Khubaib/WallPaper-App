import 'package:flutter/material.dart';
import 'LoginPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _appNameFadeAnimation; // Fade animation for app name
  late Animation<double> _appIconFadeAnimation; // Fade animation for app icon

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    // Fade animation for loading text
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Fade animation for app name
    _appNameFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Fade animation for app icon
    _appIconFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start the animation
    _controller.forward();
    _navigateToLogin();
  }

  // Navigate to LoginPage after delay
  _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 4), () {});
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // From right to left
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: FadeTransition(opacity: animation, child: child));
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white, // Background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Fade-in transition for App Icon (without scaling)
              FadeTransition(
                opacity: _appIconFadeAnimation, // Apply fade-in animation for app icon
                child: Image.asset(
                  'assets/images/appimage.png',
                  width: 150, // Icon size
                  height: 150,
                ),
              ),
              SizedBox(height: 20),

              // Fade-in transition for App Name
              FadeTransition(
                opacity: _appNameFadeAnimation, // Apply fade-in animation for app name
                child: Text(
                  'Aura Themes',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A11CB), // Purple color
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Animated Loading Text
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF6A11CB), // Purple color
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Fade-in transition for the Loading Bar
              FadeTransition(
                opacity: _fadeAnimation,
                child: SizedBox(
                  width: 170, // Extended length
                  child: LinearProgressIndicator(
                    value: null,
                    color: Color(0xFF6A11CB), // Purple color
                    backgroundColor: Color(0xFF6A11CB).withOpacity(0.3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
