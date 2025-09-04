import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isLoginVisible = true;
  bool _isLoading = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Check if the user is already logged in
    _checkIfLoggedIn();
  }

  Future<void> _checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    print("Is logged in: $isLoggedIn"); // Debug statement

    if (isLoggedIn != null && isLoggedIn) {
      // If user is logged in, navigate directly to HomePage
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _flipCard() {
    if (_isLoginVisible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _isLoginVisible = !_isLoginVisible;
    });
  }

  Future<void> _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      _showError("Passwords do not match");
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      _setLoggedIn();
    } catch (e) {
      print("Sign-up error: $e"); // Debug statement
      _showError(e.toString());
    }
  }

  Future<void> _login() async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              "Logging in...",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );

    try {
      // Firebase Login
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      print("User logged in: ${user.user?.email}");

      // Close the loading dialog first
      Navigator.of(context, rootNavigator: true).pop();

      // Set the logged-in state in SharedPreferences
      _setLoggedIn();
    } catch (e) {
      // Close the loading dialog if an error occurs
      Navigator.of(context, rootNavigator: true).pop();

      print("Login error: $e");
      _showError(e.toString());
    }
  }

  Future<void> _setLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);  // Save logged-in status

    print("SharedPreferences updated: isLoggedIn set to true"); // Debug statement

    // Navigate to HomePage
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var curve = Curves.easeInOut;
          var curvedAnimation = CurvedAnimation(parent: animation, curve: curve);

          return FadeTransition(
            opacity: curvedAnimation,
            child: child,
          );
        },
      ),
    );
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/loginsignup.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(_animation.value * 3.1416)
                    ..rotateY(_isLoginVisible ? 0 : 3.1416),
                  child: _isLoginVisible ? _buildLoginBox() : _buildSignUpBox(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBox() {
    return _buildBoxContent(
      title: 'Login',
      buttonText: 'Login',
      onMainButtonPressed: _login,
      secondaryText: "Don't have an account? Sign Up",
      onSecondaryButtonPressed: _flipCard,
    );
  }

  Widget _buildSignUpBox() {
    return _buildBoxContent(
      title: 'Sign Up',
      buttonText: 'Sign Up',
      onMainButtonPressed: _signUp,
      secondaryText: "Already have an account? Login",
      onSecondaryButtonPressed: _flipCard,
    );
  }

  Widget _buildBoxContent({
    required String title,
    required String buttonText,
    required VoidCallback onMainButtonPressed,
    required String secondaryText,
    required VoidCallback onSecondaryButtonPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(40),
      ),
      padding: const EdgeInsets.all(20.0),
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
            obscureText: true,
          ),
          if (title == 'Sign Up') ...[
            SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              obscureText: true,
            ),
          ],
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onMainButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 12),
            ),
            child: Text(buttonText),
          ),
          TextButton(
            onPressed: onSecondaryButtonPressed,
            child: Text(secondaryText),
          ),
        ],
      ),
    );
  }
}
