import 'package:bookshop_app/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/color_util.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Declare variables for email and password
  String _email = '';
  String _password = '';

  // Declare a FirebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoggedIn = false; // Track login state

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  // Function to check the login status
  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {}); // Refresh the UI
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return HomePage();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Purple,
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _signInWithEmailAndPassword();
              },
              style: ElevatedButton.styleFrom(
                primary: Purple,
              ),
              child: Text('Login'),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text(
                'Create an account',
                style: TextStyle(color: Purple),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to sign in with email and password
  void _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      if (userCredential.user != null) {
        saveLoginStatus(true); // Save login status
        setState(() {
          isLoggedIn = true; // Update login state
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // Function to save login status
  void saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }
}
